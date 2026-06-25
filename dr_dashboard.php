<?php
session_start();

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

// تأكد أنه طبيب
if ($_SESSION['role'] != 'doctor') {
    header("Location: login.php");
    exit;
}

require 'db.php';

// ✅ نجيبو الطبيب أولا
$stmt = $pdo->prepare("
    SELECT doctors.*, users.full_name 
    FROM doctors
    JOIN users ON doctors.user_id = users.id
    WHERE doctors.user_id = ?
");
$stmt->execute([$_SESSION['user_id']]);
$doctor = $stmt->fetch();
// ✅ نجيبو الحجوزات تاع هذا الطبيب
$stmt2 = $pdo->prepare("
   SELECT * FROM appointments
WHERE doctor_id = ?
AND status = 'pending'
ORDER BY created_at DESC
");

$stmt2->execute([$doctor['id']]);
$appointments = $stmt2->fetchAll(PDO::FETCH_ASSOC);
$today = date('Y-m-d');

$stmtToday = $pdo->prepare("
    SELECT * FROM appointments
    WHERE doctor_id = ?
    AND status = 'confirmed'
    AND appointment_date = ?
    ORDER BY appointment_time ASC
");

$stmtToday->execute([$doctor['id'], $today]);

$todayPatients = $stmtToday->fetchAll(PDO::FETCH_ASSOC);
$stmtMyAppointments = $pdo->prepare("
    SELECT * FROM appointments
    WHERE doctor_id = ?
    AND status = 'confirmed'
    AND appointment_date > CURDATE()
    ORDER BY appointment_date ASC, appointment_time ASC
");

$stmtMyAppointments->execute([$doctor['id']]);
$myAppointments = $stmtMyAppointments->fetchAll(PDO::FETCH_ASSOC);
$stmtHistory = $pdo->prepare("
    SELECT * FROM appointments
    WHERE doctor_id = ?
    AND status IN ('completed', 'no_show')
    ORDER BY appointment_date DESC, appointment_time DESC
");

$stmtHistory->execute([$doctor['id']]);

$historyAppointments = $stmtHistory->fetchAll(PDO::FETCH_ASSOC);
// ✅ من بعد نتحقق
if(!$doctor){
    header("Location: complete_doctor_profile.php");
    exit();
}

// إذا ماكملش البروفيل
if ($doctor['is_profile_complete'] == 0) {
    header("Location: complete_doctor_profile.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>لوحة تحكم الطبيب - التطبيق الطبي الذكي</title>
    <link rel="stylesheet" href="dr_dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- الشريط العلوي -->
    <header class="top-bar">
        <div class="header-content">
            <div class="logo-section">
                <div class="logo">
                    <img src="medchifagz.png" alt="Logo" style="width: 85px; height: 85px; object-fit: contain;">
                    <span>MedChifaGiz</span>
                    <!-- نهاية منطقة اللوغو -->
                </div>
                <div class="header-title">
                    <h1 data-ar="لوحة تحكم الطبيب" data-fr="Tableau de bord du médecin" data-en="Doctor Dashboard">لوحة تحكم الطبيب</h1>
                    <div class="user-info">
                        <i class="fas fa-user-circle"></i>
              <?php echo $doctor['full_name']; ?>

                    </div>
                </div>
            </div>
            <div class="header-actions">
                <div class="notification-btn" onclick="toggleNotifications()">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <div class="language-btn" onclick="toggleLanguage()">
                    <i class="fas fa-language"></i>
                </div>
                <div class="theme-toggle" onclick="toggleTheme()">
                    <i class="fas fa-sun"></i>
                </div>
            </div>
        </div>
        
        <!-- قائمة التنبيهات -->
        <div class="notifications-panel" id="notificationsPanel">
            <div class="notifications-header">
                <h3 data-ar="التنبيهات" data-fr="Notifications" data-en="Notifications">التنبيهات</h3>
                <button onclick="closeNotifications()"><i class="fas fa-times"></i></button>
            </div>
            <div class="notifications-list">
                <div class="notification-item unread">
                    <i class="fas fa-user-plus"></i>
                    <div class="notification-content">
                        <p data-ar="حجز جديد من المريض محمد علي" data-fr="Nouvelle réservation de Mohamed Ali" data-en="New booking from Mohamed Ali">حجز جديد من المريض محمد علي</p>
                        <span class="time" data-ar="منذ 5 دقائق" data-fr="Il y a 5 minutes" data-en="5 minutes ago">منذ 5 دقائق</span>
                    </div>
                </div>
                <div class="notification-item unread">
                    <i class="fas fa-flask"></i>
                    <div class="notification-content">
                        <p data-ar="نتائج التحليل جاهزة للمريض فاطمة" data-fr="Résultats d'analyse prêts pour Fatima" data-en="Lab results ready for Fatima">نتائج التحليل جاهزة للمريض فاطمة</p>
                        <span class="time" data-ar="منذ 30 دقيقة" data-fr="Il y a 30 minutes" data-en="30 minutes ago">منذ 30 دقيقة</span>
                    </div>
                </div>
                <div class="notification-item">
                    <i class="fas fa-comment"></i>
                    <div class="notification-content">
                        <p data-ar="رسالة جديدة من د. خالد" data-fr="Nouveau message du Dr. Khaled" data-en="New message from Dr. Khaled">رسالة جديدة من د. خالد</p>
                        <span class="time" data-ar="منذ ساعة" data-fr="Il y a 1 heure" data-en="1 hour ago">منذ ساعة</span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- المحتوى الرئيسي -->
    <main class="main-content">
        <!-- واجهة الرئيسية -->
        <section class="interface active" id="home-interface">
            <div class="cards-grid">
                <div class="main-card" onclick="toggleCard('todayPatients')">
                    <div class="card-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 data-ar="مرضى اليوم" data-fr="Patients du jour" data-en="Today's Patients">مرضى اليوم</h3>
                    <div class="card-count"><?= count($todayPatients) ?></div>
                </div>

                <div class="main-card" onclick="toggleCard('newBookings')">
                    <div class="card-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <h3 data-ar="حجوزات جديدة" data-fr="Nouvelles réservations" data-en="New Bookings">حجوزات جديدة</h3>
                   <div class="card-count"><?= count($appointments) ?></div>
                </div>
<div class="main-card" onclick="toggleCard('myAppointments')">
    <div class="card-icon">
        <i class="fas fa-calendar-check"></i>
    </div>
    <h3 data-ar="المواعيد القادمة" data-fr="Mes rendez-vous" data-en="My Appointments">
 المواعيد القادمة
    </h3>
    <div class="card-count"><?= count($myAppointments) ?></div>
</div>
<div class="main-card" onclick="toggleCard('appointmentsHistory')">
    <div class="card-icon">
        <i class="fas fa-history"></i>
    </div>
    <h3 data-ar="سجل المواعيد" data-fr="Historique" data-en="Appointments History">
        سجل المواعيد
    </h3>
    <div class="card-count"><?= count($historyAppointments) ?></div>
</div>
                <div class="main-card" onclick="toggleCard('qrScanner')">
                    <div class="card-icon">
                        <i class="fas fa-qrcode"></i>
                    </div>
                    <h3 data-ar="مسح كود QR" data-fr="Scanner QR" data-en="Scan QR Code">مسح كود QR</h3>
                </div>

                <div class="main-card" onclick="toggleCard('statistics')">
                    <div class="card-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <h3 data-ar="إحصائيات" data-fr="Statistiques" data-en="Statistics">إحصائيات</h3>
                </div>
            </div>

            <!-- محتوى البطاقات -->
            <div class="card-content" id="todayPatients">
                <div class="content-header">
                    <h2 data-ar="مرضى اليوم" data-fr="Patients du jour" data-en="Today's Patients">مرضى اليوم</h2>
                    <button onclick="closeCardContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="patients-list">

<?php if(!empty($todayPatients)): ?>

    <?php foreach($todayPatients as $patient): ?>

        <div class="patient-item">
            <div class="patient-info">
                <h4 onclick="openPatientFile(<?= $patient['patient_id'] ?>)" 
    style="cursor:pointer; color:#2563eb;">
    <?= htmlspecialchars($patient['patient_name']) ?>
</h4>

                <p class="appointment-time">
                    <?= date('H:i', strtotime($patient['appointment_time'])) ?>
                </p>
            </div>

           <div style="display:flex; gap:8px; align-items:center;">
    

    <button onclick="markCompleted(<?= $patient['id'] ?>)"
            style="background:#16a34a;color:white;border:none;padding:6px 10px;border-radius:6px;cursor:pointer;">
        ✅ حضر
    </button>

    <button onclick="markNoShow(<?= $patient['id'] ?>)"
            style="background:#dc2626;color:white;border:none;padding:6px 10px;border-radius:6px;cursor:pointer;">
        ❌ لم يحضر
    </button>
</div>
        </div>

    <?php endforeach; ?>

<?php else: ?>

    <p style="text-align:center; padding:20px; color:gray;">
        لا يوجد مرضى اليوم
    </p>

<?php endif; ?>

</div>
            </div>

<div class="card-content" id="newBookings">
    <div class="content-header">
        <h2 data-ar="حجوزات جديدة" data-fr="Nouvelles réservations" data-en="New Bookings">
            حجوزات جديدة
        </h2>
        <button onclick="closeCardContent()">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <div class="bookings-list">
        <?php if(!empty($appointments)): ?>

            <?php foreach($appointments as $app): ?>
                <div class="booking-item">

                    <div class="booking-patient">
                        <i class="fas fa-user-circle"></i>
                        <div>
                            <h4><?= htmlspecialchars($app['patient_name']) ?></h4>
                            <p><?= htmlspecialchars($app['phone']) ?></p>
                        </div>
                    </div>

                    <div class="booking-datetime">
                        <input type="date"
                               value="<?= htmlspecialchars($app['appointment_date'] ?? '') ?>"
                               id="appt_date_<?= $app['id'] ?>">

                        <input type="time"
                               value="<?= htmlspecialchars($app['appointment_time'] ?? '') ?>"
                               id="appt_time_<?= $app['id'] ?>">

                        <button onclick="confirmAppointment(<?= $app['id'] ?>)">✅ تأكيد</button>

                        <button onclick="rejectAppointment(<?= $app['id'] ?>)"
                                style="background:#dc2626;color:#fff;border:none;padding:6px 14px;border-radius:6px;cursor:pointer;margin-right:6px;">
                            ❌ رفض
                        </button>
                    </div>

                </div>
            <?php endforeach; ?>

        <?php else: ?>
            <p>ماكان حتى حجز</p>
        <?php endif; ?>
    </div>
</div>

<div class="card-content" id="myAppointments">
    <div class="content-header">
        <h2>مواعيدي</h2>
        <button onclick="closeCardContent()">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <div class="appointments-list">
        <?php if(!empty($myAppointments)): ?>

            <?php foreach($myAppointments as $app): ?>
                <div class="booking-item">
                    <div class="booking-patient">
                        <i class="fas fa-user-circle"></i>
                        <div>
                            <h4><?= htmlspecialchars($app['patient_name']) ?></h4>
                            <p>
                                <?= htmlspecialchars($app['appointment_date']) ?>
                                -
                                <?= date('H:i', strtotime($app['appointment_time'])) ?>
                            </p>
                        </div>
                    </div>

                    <div class="booking-datetime">
                       <button onclick="openRescheduleModal(<?= $app['id'] ?>)">
    ✏️ تعديل
</button>
                    </div>
                </div>
            <?php endforeach; ?>

        <?php else: ?>
            <p style="text-align:center;padding:20px;color:gray;">
                ماكان حتى موعد مؤكد
            </p>
        <?php endif; ?>
    </div>
</div>
<div class="card-content" id="appointmentsHistory">
    <div class="content-header">
        <h2>سجل المواعيد</h2>
        <button onclick="closeCardContent()">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <div class="appointments-list">

        <?php if(!empty($historyAppointments)): ?>

            <?php foreach($historyAppointments as $app): ?>

                <div class="booking-item">
                    <div class="booking-patient">
                        <i class="fas fa-user-circle"></i>
                        <div>
                            <h4><?= htmlspecialchars($app['patient_name']) ?></h4>
                            <p>
                                <?= htmlspecialchars($app['appointment_date']) ?>
                                -
                                <?= date('H:i', strtotime($app['appointment_time'])) ?>
                            </p>
                        </div>
                    </div>

                    <div>
                        <div style="display:flex; gap:10px; align-items:center;">

    <?php if($app['status'] == 'completed'): ?>
        <span style="background:#16a34a;color:white;padding:6px 10px;border-radius:6px;">
            ✅ حضر
        </span>
    <?php else: ?>
        <span style="background:#dc2626;color:white;padding:6px 10px;border-radius:6px;">
            ❌ ماجاش
        </span>
    <?php endif; ?>

    <button onclick="openRescheduleModal(<?= $app['id'] ?>)"
            style="background:#2563eb;color:white;border:none;padding:6px 12px;border-radius:6px;cursor:pointer;">
        🔄 إعادة موعد
    </button>

</div>
                    </div>
                </div>

            <?php endforeach; ?>

        <?php else: ?>

            <p style="text-align:center;padding:20px;color:gray;">
                ماكان حتى سجل
            </p>

        <?php endif; ?>

    </div>
</div>
<div class="card-content" id="qrScanner">
                <div class="content-header">
                    <h2 data-ar="مسح كود QR" data-fr="Scanner QR" data-en="Scan QR Code">مسح كود QR</h2>
                    <button onclick="closeCardContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="qr-scanner">
                    <div class="scanner-area">
                        <i class="fas fa-qrcode"></i>
                        <p data-ar="اضغط لفتح الكاميرا" data-fr="Appuyez pour ouvrir la caméra" data-en="Tap to open camera">اضغط لفتح الكاميرا</p>
                        <button class="scan-btn" data-ar="فتح الكاميرا" data-fr="Ouvrir la caméra" data-en="Open Camera">فتح الكاميرا</button>
                    </div>
                    <div class="scanned-result" style="display: none;">
                        <i class="fas fa-check-circle"></i>
                        <p data-ar="تم المسح بنجاح" data-fr="Scanné avec succès" data-en="Scanned successfully">تم المسح بنجاح</p>
                        <button class="view-file-btn" data-ar="اطّلع على الملف الطبي" data-fr="Voir le dossier médical" data-en="View Medical File">اطّلع على الملف الطبي</button>
                    </div>
                </div>
            </div>

            <div class="card-content" id="statistics">
                <div class="content-header">
                    <h2 data-ar="إحصائيات" data-fr="Statistiques" data-en="Statistics">إحصائيات</h2>
                    <button onclick="closeCardContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="statistics-content">
                    <canvas id="weeklyChart"></canvas>
                    <div class="stats-summary">
                        <div class="stat-item">
                            <i class="fas fa-users"></i>
                            <div>
                                <h4>85</h4>
                                <p data-ar="مريض هذا الأسبوع" data-fr="Patients cette semaine" data-en="Patients this week">مريض هذا الأسبوع</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <i class="fas fa-calendar-check"></i>
                            <div>
                                <h4>92%</h4>
                                <p data-ar="نسبة الحضور" data-fr="Taux de présence" data-en="Attendance rate">نسبة الحضور</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- واجهة الذكاء الاصطناعي -->
        <section class="interface" id="ai-interface">
            <div class="ai-hero-card">
                <div class="pulsing-brain">
                    <i class="fas fa-brain"></i>
                </div>
                <h2 data-ar="مساعدك الذكي جاهز للعمل" data-fr="Votre assistant intelligent est prêt" data-en="Your Smart Assistant is Ready">مساعدك الذكي جاهز للعمل</h2>
                <p data-ar="استخدم قوة الذكاء الاصطناعي لتحسين سير عملك الطبي" data-fr="Utilisez la puissance de l'IA pour améliorer votre pratique médicale" data-en="Use the power of AI to enhance your medical workflow">استخدم قوة الذكاء الاصطناعي لتحسين سير عملك الطبي</p>
                <div class="ai-features">
                    <div class="ai-feature">
                        <i class="fas fa-chart-line"></i>
                        <p data-ar="دقة 97%" data-fr="Précision 97%" data-en="97% Accuracy">دقة 97%</p>
                    </div>
                    <div class="ai-feature">
                        <i class="fas fa-clock"></i>
                        <p data-ar="توفير 3 ساعات يومياً" data-fr="Économie de 3h/jour" data-en="Save 3 hours daily">توفير 3 ساعات يومياً</p>
                    </div>
                    <div class="ai-feature">
                        <i class="fas fa-shield-alt"></i>
                        <p data-ar="آمن ومشفر" data-fr="Sécurisé et crypté" data-en="Secure & Encrypted">آمن ومشفر</p>
                    </div>
                </div>
            </div>

            <div class="ai-cards-grid">
                <div class="ai-card" onclick="toggleAICard('autoOrganize')">
                    <div class="ai-badge">AI</div>
                    <i class="fas fa-folder-open"></i>
                    <h3 data-ar="تنظيم الملفات تلقائياً" data-fr="Organisation automatique" data-en="Auto Organize Files">تنظيم الملفات تلقائياً</h3>
                </div>

                <div class="ai-card" onclick="toggleAICard('patientArchive')">
                    <div class="ai-badge">AI</div>
                    <i class="fas fa-archive"></i>
                    <h3 data-ar="أرشيف المرضى" data-fr="Archive des patients" data-en="Patient Archive">أرشيف المرضى</h3>
                </div>

                <div class="ai-card" onclick="toggleAICard('reportGen')">
                    <div class="ai-badge">AI</div>
                    <i class="fas fa-file-medical"></i>
                    <h3 data-ar="توليد تقارير طبية" data-fr="Générer des rapports" data-en="Generate Reports">توليد تقارير طبية</h3>
                </div>
            </div>

            <!-- محتوى بطاقات الذكاء الاصطناعي -->
            <div class="ai-content" id="autoOrganize">
                <div class="content-header">
                    <h2 data-ar="تنظيم الملفات تلقائياً" data-fr="Organisation automatique" data-en="Auto Organize Files">تنظيم الملفات تلقائياً</h2>
                    <button onclick="closeAIContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="organized-patients">
                    <div class="patient-category">
                        <h3 data-ar="مستعجل" data-fr="Urgent" data-en="Urgent">مستعجل</h3>
                        <div class="category-patients">
                            <div class="patient-card urgent">
                                <i class="fas fa-exclamation-circle"></i>
                                <span>محمد علي - حالة طارئة</span>
                            </div>
                            <div class="patient-card urgent">
                                <i class="fas fa-exclamation-circle"></i>
                                <span>سارة أحمد - ألم حاد</span>
                            </div>
                        </div>
                    </div>
                    <div class="patient-category">
                        <h3 data-ar="مزمن" data-fr="Chronique" data-en="Chronic">مزمن</h3>
                        <div class="category-patients">
                            <div class="patient-card chronic">
                                <i class="fas fa-heartbeat"></i>
                                <span>أحمد يوسف - سكري</span>
                            </div>
                            <div class="patient-card chronic">
                                <i class="fas fa-heartbeat"></i>
                                <span>فاطمة حسن - ضغط</span>
                            </div>
                        </div>
                    </div>
                    <div class="patient-category">
                        <h3 data-ar="متابعات" data-fr="Suivis" data-en="Follow-ups">متابعات</h3>
                        <div class="category-patients">
                            <div class="patient-card followup">
                                <i class="fas fa-calendar-check"></i>
                                <span>خالد محمود - متابعة شهرية</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ai-content" id="patientArchive">
                <div class="content-header">
                    <h2 data-ar="أرشيف المرضى" data-fr="Archive des patients" data-en="Patient Archive">أرشيف المرضى</h2>
                    <button onclick="closeAIContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="archive-search">
                    <input type="text" placeholder="ابحث عن مريض..." data-ar-placeholder="ابحث عن مريض..." data-fr-placeholder="Rechercher un patient..." data-en-placeholder="Search for a patient...">
                    <i class="fas fa-search"></i>
                </div>
                <div class="archive-list">
                    <div class="archive-item">
                        <div class="archive-patient-info">
                            <i class="fas fa-user-circle"></i>
                            <div>
                                <h4>محمد علي</h4>
                                <p>آخر زيارة: 15/01/2026</p>
                            </div>
                        </div>
                        <button class="view-records-btn" data-ar="عرض السجلات" data-fr="Voir dossiers" data-en="View Records">عرض السجلات</button>
                    </div>
                    <div class="archive-item">
                        <div class="archive-patient-info">
                            <i class="fas fa-user-circle"></i>
                            <div>
                                <h4>فاطمة حسن</h4>
                                <p>آخر زيارة: 10/01/2026</p>
                            </div>
                        </div>
                        <button class="view-records-btn" data-ar="عرض السجلات" data-fr="Voir dossiers" data-en="View Records">عرض السجلات</button>
                    </div>
                </div>
            </div>

            <div class="ai-content" id="reportGen">
                <div class="content-header">
                    <h2 data-ar="توليد تقارير طبية" data-fr="Générer des rapports" data-en="Generate Reports">توليد تقارير طبية</h2>
                    <button onclick="closeAIContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="report-form">
                    <div class="form-group">
                        <label data-ar="اختر المريض" data-fr="Sélectionner le patient" data-en="Select Patient">اختر المريض</label>
                        <select>
                            <option>محمد علي</option>
                            <option>فاطمة حسن</option>
                            <option>أحمد يوسف</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label data-ar="ملاحظات الطبيب" data-fr="Notes du médecin" data-en="Doctor's Notes">ملاحظات الطبيب</label>
                        <textarea rows="5" placeholder="أدخل ملاحظاتك هنا..." data-ar-placeholder="أدخل ملاحظاتك هنا..." data-fr-placeholder="Entrez vos notes ici..." data-en-placeholder="Enter your notes here..."></textarea>
                    </div>
                    <button class="generate-report-btn" data-ar="توليد تقرير طبي" data-fr="Générer le rapport" data-en="Generate Report">توليد تقرير طبي</button>
                </div>
            </div>

            <!-- مساعد طبي ذكي -->
            <div class="ai-assistant-btn" onclick="toggleAssistant()">
                <div class="assistant-pulse"></div>
                <i class="fas fa-robot"></i>
            </div>

            <div class="assistant-chat" id="assistantChat">
                <div class="chat-header">
                    <h3 data-ar="المساعد الطبي الذكي" data-fr="Assistant médical intelligent" data-en="Smart Medical Assistant">المساعد الطبي الذكي</h3>
                    <button onclick="closeAssistant()"><i class="fas fa-times"></i></button>
                </div>
                <div class="chat-messages">
                    <div class="message ai-message">
                        <p data-ar="مرحباً! كيف يمكنني مساعدتك اليوم؟" data-fr="Bonjour! Comment puis-je vous aider aujourd'hui?" data-en="Hello! How can I help you today?">مرحباً! كيف يمكنني مساعدتك اليوم؟</p>
                    </div>
                </div>
                <div class="chat-input">
                    <input type="text" placeholder="اكتب رسالتك..." data-ar-placeholder="اكتب رسالتك..." data-fr-placeholder="Écrivez votre message..." data-en-placeholder="Type your message...">
                    <button><i class="fas fa-paper-plane"></i></button>
                </div>
            </div>
        </section>

        <!-- واجهة المحادثات -->
        <section class="interface" id="messages-interface">
            <div class="messages-cards">
                <div class="message-card" onclick="toggleMessageCard('patientChats')">
                    <i class="fas fa-user-injured"></i>
                    <h3 data-ar="المرضى" data-fr="Patients" data-en="Patients">المرضى</h3>
                    <span class="message-count">8</span>
                </div>

                <div class="message-card" onclick="toggleMessageCard('doctorChats')">
                    <i class="fas fa-user-md"></i>
                    <h3 data-ar="شبكة الأطباء" data-fr="Réseau de médecins" data-en="Doctors Network">شبكة الأطباء</h3>
                    <span class="message-count">3</span>
                </div>
            </div>

            <div class="chat-content" id="patientChats">
                <div class="content-header">
                    <h2 data-ar="محادثات المرضى" data-fr="Chats patients" data-en="Patient Chats">محادثات المرضى</h2>
                    <button onclick="closeMessageContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="chat-list">
                    <div class="chat-item">
                        <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50'%3E%3Ccircle cx='25' cy='25' r='25' fill='%234A90E2'/%3E%3Ctext x='50%25' y='50%25' text-anchor='middle' dy='.3em' fill='white' font-size='20' font-family='Arial'%3Eم%3C/text%3E%3C/svg%3E" alt="patient">
                        <div class="chat-info">
                            <h4>محمد علي</h4>
                            <p>شكراً دكتور على المتابعة...</p>
                        </div>
                        <div class="chat-meta">
                            <span class="time">10:30</span>
                            <span class="unread-badge">2</span>
                        </div>
                    </div>
                    <div class="chat-item">
                        <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50'%3E%3Ccircle cx='25' cy='25' r='25' fill='%2350C878'/%3E%3Ctext x='50%25' y='50%25' text-anchor='middle' dy='.3em' fill='white' font-size='20' font-family='Arial'%3Eف%3C/text%3E%3C/svg%3E" alt="patient">
                        <div class="chat-info">
                            <h4>فاطمة حسن</h4>
                            <p>هل يمكن تغيير الموعد؟</p>
                        </div>
                        <div class="chat-meta">
                            <span class="time">أمس</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="chat-content" id="doctorChats">
                <!-- سيتم تحميل واجهة المحادثة الكاملة هنا عبر JavaScript -->
            </div>
        </section>

        <!-- واجهة الخدمات الخارجية -->
        <section class="interface" id="services-interface">
            <div class="services-cards">
                <div class="service-card" onclick="toggleServiceCard('labResults')">
                    <i class="fas fa-flask"></i>
                    <h3 data-ar="النتائج المخبرية" data-fr="Résultats de laboratoire" data-en="Lab Results">النتائج المخبرية</h3>
                </div>

                <div class="service-card" onclick="toggleServiceCard('medicalSupplies')">
                    <i class="fas fa-clinic-medical"></i>
                    <h3 data-ar="دليل المستلزمات الطبية" data-fr="Guide des fournitures" data-en="Medical Supplies Guide">دليل المستلزمات الطبية</h3>
                </div>

                <div class="service-card" onclick="toggleServiceCard('suppliesAssistant')">
                    <i class="fas fa-boxes"></i>
                    <h3 data-ar="مساعد المستلزمات الذكي" data-fr="Assistant intelligent" data-en="Smart Supplies Assistant">مساعد المستلزمات الذكي</h3>
                </div>
            </div>

            <div class="service-content" id="labResults">
                <div class="content-header">
                    <h2 data-ar="النتائج المخبرية" data-fr="Résultats de laboratoire" data-en="Lab Results">النتائج المخبرية</h2>
                    <button onclick="closeServiceContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="lab-scanner">
                    <div class="scanner-area">
                        <i class="fas fa-qrcode"></i>
                        <p data-ar="امسح كود QR لعرض النتائج المخبرية" data-fr="Scannez le QR code pour voir les résultats" data-en="Scan QR code to view lab results">امسح كود QR لعرض النتائج المخبرية</p>
                        <button class="scan-btn lab-scan-btn" data-ar="مسح الكود" data-fr="Scanner" data-en="Scan Code">مسح الكود</button>
                    </div>
                    <div class="scanned-result lab-result-display" style="display: none;">
                        <i class="fas fa-check-circle" style="color: #50C878; font-size: 3rem; margin-bottom: 1rem;"></i>
                        <p style="margin-bottom: 1.5rem; color: #50C878; font-weight: 600;">تم مسح الكود بنجاح</p>
                        <button class="view-lab-results-btn" style="padding: 1rem 2rem; background: #4A90E2; color: white; border: none; border-radius: 10px; font-size: 1rem; font-weight: 600; cursor: pointer;" data-ar="اطّلع على نتائج التحاليل" data-fr="Voir les résultats" data-en="View Lab Results">اطّلع على نتائج التحاليل</button>
                    </div>
                </div>
            </div>

            <div class="service-content" id="medicalSupplies">
                <div class="content-header">
                    <h2 data-ar="دليل المستلزمات الطبية" data-fr="Guide des fournitures" data-en="Medical Supplies Guide">دليل المستلزمات الطبية</h2>
                    <button onclick="closeServiceContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="supplies-list">
                    <div class="supply-item">
                        <i class="fas fa-store"></i>
                        <div class="supply-info">
                            <h4>صيدلية النور</h4>
                            <p>شارع الجمهورية - جميع المستلزمات الطبية</p>
                            <span class="location"><i class="fas fa-map-marker-alt"></i> 2.5 كم</span>
                        </div>
                    </div>
                    <div class="supply-item">
                        <i class="fas fa-store"></i>
                        <div class="supply-info">
                            <h4>مركز الشفاء الطبي</h4>
                            <p>حي السلام - أجهزة ومعدات طبية</p>
                            <span class="location"><i class="fas fa-map-marker-alt"></i> 3.8 كم</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="service-content" id="suppliesAssistant">
                <div class="content-header">
                    <h2 data-ar="مساعد المستلزمات الذكي" data-fr="Assistant intelligent" data-en="Smart Supplies Assistant">مساعد المستلزمات الذكي</h2>
                    <button onclick="closeServiceContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="supplies-assistant-card">
                    <div class="assistant-header">
                        <div class="assistant-avatar">
                            <i class="fas fa-robot"></i>
                        </div>
                        <div class="assistant-info">
                            <h3>مساعد المستلزمات الذكي</h3>
                            <p>اسألني عن أي مستلزمات طبية تحتاجها</p>
                        </div>
                    </div>
                    <div class="supplies-chat-messages" id="suppliesChatMessages">
                        <div class="message ai-message">
                            <p>مرحباً! 👋<br>أنا مساعدك الذكي للمستلزمات الطبية.<br><br>يمكنني مساعدتك في إيجاد:<br>• قفازات طبية<br>• كمامات<br>• حقن وسرنجات<br>• ضمادات وشاش<br>• معقمات<br>• أجهزة قياس<br>• وغيرها الكثير!<br><br>ماذا تحتاج؟</p>
                        </div>
                    </div>
                    <div class="supplies-chat-input">
                        <input type="text" id="suppliesInput" placeholder="اسأل عن مستلزمات طبية..." onkeypress="handleSuppliesEnter(event)">
                        <button onclick="sendSuppliesMessage()"><i class="fas fa-paper-plane"></i></button>
                    </div>
                </div>
            </div>
        </section>

        <!-- واجهة الإعدادات -->
        <section class="interface" id="settings-interface">
            <!-- رأس الملف الشخصي -->
            <div class="settings-profile-header">
                <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='80' height='80'%3E%3Ccircle cx='40' cy='40' r='40' fill='%234A90E2'/%3E%3Ctext x='50%25' y='50%25' text-anchor='middle' dy='.3em' fill='white' font-size='32' font-family='Arial'%3Eد%3C/text%3E%3C/svg%3E" alt="Profile">
                <h3>د. <?php echo $doctor['full_name']; ?></h3>
            <p>
<?php echo $doctor['specialty'] ?? ''; ?> • 
<?php echo $doctor['experience'] ?? '0'; ?> سنة خبرة
</p>
            </div>

            <!-- قائمة الإعدادات -->
            <div class="settings-list">
                <!-- الحساب -->
                <div class="settings-group">
                    <h4 class="settings-group-title">الحساب</h4>
                    <div class="settings-option" onclick="openEditProfile()">
                        <div class="settings-option-content">
                            <div class="settings-icon">
                                <i class="fas fa-user-edit"></i>
                            </div>
                            <div class="settings-text">
                                <span>تعديل الملف الشخصي</span>
                                <small>تحديث الاسم والمعلومات</small>
                            </div>
                        </div>
                        <i class="fas fa-chevron-left"></i>
                    </div>
                    <div class="settings-option" onclick="openChangePassword()">
                        <div class="settings-option-content">
                            <div class="settings-icon">
                                <i class="fas fa-lock"></i>
                            </div>
                            <div class="settings-text">
                                <span>تغيير كلمة المرور</span>
                                <small>حماية حسابك</small>
                            </div>
                        </div>
                        <i class="fas fa-chevron-left"></i>
                    </div>
                </div>

                <!-- المرضى -->
                <div class="settings-group">
                    <h4 class="settings-group-title">المرضى</h4>
                    <div class="settings-option" onclick="openMyPatients()">
                        <div class="settings-option-content">
                            <div class="settings-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="settings-text">
                                <span>مرضاي</span>
                                <small>عرض وإدارة جميع المرضى</small>
                            </div>
                        </div>
                        <i class="fas fa-chevron-left"></i>
                    </div>
                </div>

                <!-- التطبيق -->
                <div class="settings-group">
                    <h4 class="settings-group-title">التطبيق</h4>
                    <div class="settings-option">
                        <div class="settings-option-content">
                            <div class="settings-icon">
                                <i class="fas fa-bell"></i>
                            </div>
                            <div class="settings-text">
                                <span>الإشعارات</span>
                                <small>إدارة التنبيهات</small>
                            </div>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" checked>
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                    <div class="settings-option">
                        <div class="settings-option-content">
                            <div class="settings-icon">
                                <i class="fas fa-moon"></i>
                            </div>
                            <div class="settings-text">
                                <span>الوضع الليلي</span>
                                <small>تفعيل المظهر الداكن</small>
                            </div>
                        </div>
                        <label class="toggle-switch">
                            <input type="checkbox" onchange="toggleTheme()">
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                </div>

                <!-- الخروج -->
                <div class="settings-group">
                    <a href="logout.php" class="settings-option logout-option" style="text-decoration:none;">
                        <div class="settings-option-content">
                            <div class="settings-icon logout-icon">
                                <i class="fas fa-sign-out-alt"></i>
                            </div>
                            <div class="settings-text">
                                <span style="color: #ff3b30; font-weight: 600;">تسجيل الخروج</span>
                            </div>
</a>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- نوافذ الإعدادات -->
    <div class="settings-modal" id="editProfileModal">
        <div class="settings-modal-content">
            <div class="settings-modal-header">
                <h3>تعديل الملف الشخصي</h3>
                <button onclick="closeModal('editProfileModal')"><i class="fas fa-times"></i></button>
            </div>
            <div class="settings-modal-body">
                <div class="form-group">
                    <label>الاسم الكامل</label>
                    <input type="text" value="<?php echo $doctor['full_name']; ?>" class="form-input">
                </div>
                <div class="form-group">
                    <label>التخصص</label>
                    <input type="text" value="<?php echo $doctor['specialty'] ?? ''; ?>" class="form-input">
                </div>
                <div class="form-group">
                    <label>سنوات الخبرة</label>
                    <input type="number" value="<?php echo $doctor['experience'] ?? 0; ?>" class="form-input">
                </div>
                <div class="form-group">
                    <label>رقم الهاتف</label>
                    <input type="text" value="<?php echo $doctor['phone'] ?? ''; ?>" class="form-input">
                </div>
            </div>
            <div class="settings-modal-footer">
                <button class="btn-secondary" onclick="closeModal('editProfileModal')">إلغاء</button>
                <button class="btn-primary" onclick="saveProfile()">حفظ</button>
            </div>
        </div>
    </div>

    <div class="settings-modal" id="changePasswordModal">
        <div class="settings-modal-content">
            <div class="settings-modal-header">
                <h3>تغيير كلمة المرور</h3>
                <button onclick="closeModal('changePasswordModal')"><i class="fas fa-times"></i></button>
            </div>
            <div class="settings-modal-body">
                <div class="form-group">
                    <label>كلمة المرور الحالية</label>
                    <input type="password" placeholder="أدخل كلمة المرور الحالية" class="form-input">
                </div>
                <div class="form-group">
                    <label>كلمة المرور الجديدة</label>
                    <input type="password" placeholder="أدخل كلمة المرور الجديدة" class="form-input">
                </div>
                <div class="form-group">
                    <label>تأكيد كلمة المرور</label>
                    <input type="password" placeholder="أعد إدخال كلمة المرور" class="form-input">
                </div>
            </div>
            <div class="settings-modal-footer">
                <button class="btn-secondary" onclick="closeModal('changePasswordModal')">إلغاء</button>
                <button class="btn-primary" onclick="changePassword()">تغيير</button>
            </div>
        </div>
    </div>

    <div class="settings-modal patients-modal" id="myPatientsModal">
        <div class="settings-modal-content">
            <div class="settings-modal-header">
                <h3>مرضاي</h3>
                <button onclick="closeModal('myPatientsModal')"><i class="fas fa-times"></i></button>
            </div>
            <div class="settings-modal-body">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="بحث عن مريض..." onkeyup="searchPatients(this.value)">
                </div>
                <div id="patientsList"></div>
                <div id="appointmentsContainer"></div>
            </div>
        </div>
    </div>

    <!-- الشريط السفلي -->
    <nav class="bottom-bar">
        <div class="nav-item active" onclick="switchInterface('home')">
            <i class="fas fa-home"></i>
            <span data-ar="الرئيسية" data-fr="Accueil" data-en="Home">الرئيسية</span>
        </div>
        <div class="nav-item" onclick="switchInterface('ai')">
            <i class="fas fa-robot"></i>
            <span data-ar="الذكاء الاصطناعي" data-fr="IA" data-en="AI">الذكاء الاصطناعي</span>
        </div>
        <div class="nav-item" onclick="switchInterface('messages')">
            <i class="fas fa-comments"></i>
            <span data-ar="المحادثات" data-fr="Messages" data-en="Messages">المحادثات</span>
        </div>
        <div class="nav-item" onclick="switchInterface('services')">
            <i class="fas fa-box"></i>
            <span data-ar="الخدمات" data-fr="Services" data-en="Services">الخدمات</span>
        </div>
        <div class="nav-item" onclick="switchInterface('settings')">
            <i class="fas fa-cog"></i>
            <span data-ar="الإعدادات" data-fr="Paramètres" data-en="Settings">الإعدادات</span>
        </div>
    </nav>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="dr_dashboard.js"></script>
<div id="rescheduleModal" style="display:none; position:fixed; inset:0; background:rgba(0,0,0,.45); z-index:9999; align-items:center; justify-content:center;">
    <div style="background:#fff; width:90%; max-width:420px; padding:25px; border-radius:14px;">
        <h3 style="margin-bottom:20px;">🔄 إعادة برمجة موعد</h3>

        <input type="hidden" id="reschedule_id">

        <label>التاريخ الجديد:</label>
        <input type="date" id="reschedule_date"
               style="width:100%; padding:10px; margin:8px 0 15px; border:1px solid #ddd; border-radius:8px;">

        <label>الوقت الجديد:</label>
        <input type="time" id="reschedule_time"
               style="width:100%; padding:10px; margin:8px 0 20px; border:1px solid #ddd; border-radius:8px;">

        <div style="display:flex; gap:10px;">
            <button onclick="saveReschedule()"
                    style="flex:1; background:#16a34a; color:white; border:none; padding:10px; border-radius:8px; cursor:pointer;">
                💾 حفظ
            </button>

            <button onclick="closeRescheduleModal()"
                    style="flex:1; background:#dc2626; color:white; border:none; padding:10px; border-radius:8px; cursor:pointer;">
                إلغاء
            </button>
        </div>
    </div>
</div>
<!-- Patient Medical File Modal -->
<div id="patientFileModal" class="patient-modal" style="display:none;">
    <div class="patient-modal-content">

        <span class="close-patient-modal" onclick="closePatientFile()">✖</span>

        <h2>📋 الملف الطبي للمريض</h2>

        <!-- STEP 1 -->
        <div class="medical-step active-step" id="step1">
            <h3>👤 المعلومات الشخصية</h3>

            <div class="form-group">
                <label>👤 اسم ولقب المريض</label>
                <input type="text" id="full_name">
            </div>

            <div class="form-group">
                <label>🎂 تاريخ ومكان الميلاد</label>
                <input type="text" id="birth_info">
            </div>

            <div class="form-group">
                <label>💍 الحالة العائلية</label>
                <input type="text" id="marital_status">
            </div>

            <div class="form-group">
                <label>💼 طبيعة العمل</label>
                <input type="text" id="job">
            </div>

            <div class="form-group">
                <label>📍 العنوان</label>
                <input type="text" id="address">
            </div>

            <div class="form-group">
                <label>📞 رقم الهاتف</label>
                <input type="text" id="phone">
            </div>

            <button class="next-btn" onclick="nextStep(2)">التالي ⬅</button>
        </div>

       <!-- STEP 2 -->
<div class="medical-step" id="step2">

    <h3>🩺 L'interrogatoire</h3>

    <div class="form-group">
        <label>📌 سبب الفحص</label>
        <textarea id="reason_exam"></textarea>
    </div>

    <div class="form-group">
        <label>🤒 الأعراض</label>
        <textarea id="symptoms"></textarea>
    </div>

    <div class="form-group">
        <label>🩸 مقياس ضغط الدم</label>
        <input type="text" id="blood_pressure">
    </div>

    <div class="form-group">
        <label>🍬 نسبة السكر في الدم</label>
        <input type="text" id="blood_sugar">
    </div>

    <div class="form-group">
        <label>❤️ معدل ضربات القلب</label>
        <input type="text" id="heart_rate">
    </div>

    <div class="form-group">
        <label>🌡️ درجة الحرارة</label>
        <input type="text" id="temperature">
    </div>

    <div class="form-group">
        <label>🫁 نسبة الأكسجين</label>
        <input type="text" id="oxygen_level">
    </div>

    <div class="form-group">
        <label>💊 الأمراض المزمنة (المريض)</label>
        <textarea id="chronic_patient"></textarea>
    </div>

    <div class="form-group">
        <label>👨‍👩‍👧‍👦 الأمراض المزمنة (العائلة)</label>
        <textarea id="chronic_family"></textarea>
    </div>

   <div class="step-buttons">
    <button class="prev-btn" onclick="prevStep(1)">➡ رجوع</button>
    <button class="next-btn" onclick="nextStep(3)">التالي ⬅</button>
</div>

</div>
<!-- STEP 3 -->
<div class="medical-step" id="step3">

    <h3>🧪 Examen complémentaire</h3>

    <div class="form-group">
        <label>🧫 التحاليل الطبية</label>
        <textarea id="medical_tests"></textarea>
    </div>

    <div class="form-group">
        <label>🩻 الأشعة (Radiologie)</label>
        <textarea id="radiology"></textarea>
    </div>

    <div class="step-buttons">
        <button class="prev-btn" onclick="prevStep(2)">➡ رجوع</button>
        <button class="next-btn" onclick="nextStep(4)">التالي ⬅</button>
    </div>

</div>
<div class="medical-step" id="step4">

    <div id="prescriptionSheet" class="prescription-sheet">

        <div class="rx-top">
            <div class="doctor-box">
                <h2>Dr. <?= htmlspecialchars($doctor['full_name']) ?></h2>
                <p><?= htmlspecialchars($doctor['specialty']) ?></p>
                <p>رقم الاعتماد: <?= htmlspecialchars($doctor['license_number']) ?></p>
                <p>
                    <?= htmlspecialchars($doctor['workplace']) ?> -
                    <?= htmlspecialchars($doctor['commune']) ?> -
                    <?= htmlspecialchars($doctor['wilaya']) ?>
                </p>
            </div>

            <div class="patient-box">
                <p><strong>اسم المريض:</strong></p>
                <input type="text" id="rx_patient_name">

                <p><strong>التاريخ:</strong></p>
                <input type="date" id="rx_date" value="<?= date('Y-m-d') ?>">
            </div>
        </div>

        <hr>

        <h1 class="rx-title">ORDONNANCE</h1>

        <div class="rx-body">
            <textarea
                id="prescription"
                placeholder="اكتب الأدوية هنا..."
            ></textarea>
        </div>

        <div class="rx-notes">
            <textarea
                id="doctor_notes"
                placeholder="تعليمات الطبيب..."
            ></textarea>
        </div>

        <div class="rx-sign">
            <input
                type="text"
                id="doctor_signature"
                value="Dr. <?= htmlspecialchars($doctor['full_name']) ?>"
            >
        </div>
    </div>

    <div class="step-buttons">
        <button class="prev-btn" onclick="prevStep(3)">⬅ رجوع</button>

        <button type="button" class="save-btn" onclick="savePrescription()">
            💾 حفظ الوصفة
        </button>

        <button type="button" class="print-btn" onclick="printPrescription()">
            🖨️ طباعة الوصفة
        </button>
<?php if(trim($doctor['specialty']) == 'أمراض النساء والتوليد'): ?>
    <button class="next-btn" onclick="nextStep(5)">التالي ➜</button>
<?php else: ?>
    <button class="next-btn" onclick="nextStep(6)">التالي ➜</button>
<?php endif; ?>
    </div>

</div>
<!-- STEP 5 : Pregnancy -->
<?php if(trim($doctor['specialty']) == 'أمراض النساء والتوليد'): ?>
<div class="medical-step" id="step5">

    <h3>🤰 متابعة الحمل</h3>

    <div style="background:#f8fafc;padding:20px;border-radius:14px;margin-bottom:20px;">
        <h4>🟦 بطاقة الحمل</h4>

        <div class="form-group">
            <label>📅 تاريخ آخر دورة</label>
            <input type="date" id="last_period_date">
        </div>

        <div class="form-group">
            <label>📆 تاريخ الولادة المتوقع</label>
            <input type="date" id="expected_delivery_date">
        </div>

        <div class="form-group">
            <label>🩸 فصيلة الدم</label>
            <input type="text" id="preg_blood_type">
        </div>

        <div class="form-group">
            <label>🤱 عدد مرات الحمل (G)</label>
            <input type="number" id="pregnancies_count">
        </div>

        <div class="form-group">
            <label>👶 عدد الولادات (P)</label>
            <input type="number" id="births_count">
        </div>

        <div class="form-group">
            <label>⚠️ إجهاضات سابقة</label>
            <input type="number" id="miscarriages_count">
        </div>

        <div class="form-group">
            <label>🏥 قيصرية سابقة</label>
            <input type="number" id="c_sections_count">
        </div>

        <div class="form-group">
            <label>💊 أمراض مزمنة</label>
            <textarea id="preg_chronic_diseases"></textarea>
        </div>

        <div class="form-group">
            <label>👨 حالة الأب</label>
            <input type="text" id="father_status">
        </div>

        <div class="form-group">
            <label>👪 زواج الأقارب</label>
            <select id="consanguinity">
                <option value="no">لا</option>
                <option value="yes">نعم</option>
            </select>
        </div>

        <div class="form-group">
            <label>📝 ملاحظات عامة</label>
            <textarea id="pregnancy_notes"></textarea>
        </div>
    </div>

    <div style="background:#ecfeff;padding:20px;border-radius:14px;">
        <h4>🟩 متابعة الحمل</h4>

        <div class="form-group">
            <label>⚖️ الوزن</label>
            <input type="text" id="preg_weight">
        </div>

        <div class="form-group">
            <label>🩺 ضغط الدم</label>
            <input type="text" id="preg_blood_pressure">
        </div>

        <div class="form-group">
            <label>🍬 السكر</label>
            <input type="text" id="preg_sugar_level">
        </div>

        <div class="form-group">
            <label>❤️ نبض الجنين</label>
            <input type="text" id="fetal_heartbeat">
        </div>

        <div class="form-group">
            <label>🦶 حركة الجنين</label>
            <input type="text" id="fetal_movement">
        </div>

        <div class="form-group">
            <label>📏 وزن/حجم الجنين</label>
            <input type="text" id="fetal_weight">
        </div>

        <div class="form-group">
            <label>🧭 وضعية الجنين</label>
            <input type="text" id="fetal_position">
        </div>

        <div class="form-group">
            <label>🖥️ ملاحظات الإيكوغرافيا</label>
            <textarea id="echo_notes"></textarea>
        </div>

        <div class="form-group">
            <label>📝 ملاحظات الطبيب</label>
            <textarea id="followup_notes"></textarea>
        </div>
    </div>

    <div class="step-buttons">
        <button class="prev-btn" onclick="prevStep(4)">➡ رجوع</button>
        <button class="next-btn" onclick="nextStep(6)">التالي ⬅</button>
    </div>

</div>
<?php endif; ?>
<!-- STEP 6 -->
<div class="medical-step" id="step6">

    <h3>📅 المواعيد القادمة</h3>

    <div class="form-group">
        <label>هل يحتاج موعد جديد؟</label>
        <select id="needs_appointment">
            <option value="no">لا</option>
            <option value="yes">نعم</option>
        </select>
    </div>

    <div id="appointmentFields" style="display:none;">
        <div class="form-group">
            <label>📆 التاريخ</label>
            <input type="date" id="next_appointment_date">
        </div>

        <div class="form-group">
            <label>🕒 الوقت</label>
            <input type="time" id="next_appointment_time">
        </div>
    </div>

    <div class="step-buttons">
        <button class="prev-btn" onclick="prevStep(5)">➡ رجوع</button>
        <button type="button" class="print-btn" onclick="printMedicalRecord()">
    🖨️ طباعة السجل
</button>
        <button class="next-btn" onclick="saveMedicalRecord()">💾 حفظ الملف</button>
    </div>

</div>

    </div>
</div>
</div>
</body>
</html>
