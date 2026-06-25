<?php
session_start();
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

$stmtDoctor = $pdo->prepare("SELECT id FROM doctors WHERE user_id = ?");
$stmtDoctor->execute([$_SESSION['user_id']]);
$doctor = $stmtDoctor->fetch(PDO::FETCH_ASSOC);

$doctor_id = $doctor['id'];
    $patient_id = $_POST['patient_id'];

    // حفظ السجل الطبي
    $stmt = $pdo->prepare("
        INSERT INTO medical_records (
            patient_id, doctor_id,
            full_name, birth_info, marital_status, job, address, phone,
            reason_exam, symptoms,
            blood_pressure, blood_sugar, heart_rate, temperature, oxygen_level,
            chronic_patient, chronic_family,
            medical_tests, radiology,
            prescription, next_appointment,
            next_appointment_date, next_appointment_time
        ) VALUES (
            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
        )
    ");

    $stmt->execute([
        $patient_id,
        $doctor_id,
        $_POST['full_name'],
        $_POST['birth_info'],
        $_POST['marital_status'],
        $_POST['job'],
        $_POST['address'],
        $_POST['phone'],
        $_POST['reason_exam'],
        $_POST['symptoms'],
        $_POST['blood_pressure'],
        $_POST['blood_sugar'],
        $_POST['heart_rate'],
        $_POST['temperature'],
        $_POST['oxygen_level'],
        $_POST['chronic_patient'],
        $_POST['chronic_family'],
        $_POST['medical_tests'],
        $_POST['radiology'],
        $_POST['prescription'],
        $_POST['needs_appointment'],
        $_POST['next_appointment_date'],
        $_POST['next_appointment_time']
    ]);

    // إذا كاين موعد جديد -> خزنيه في appointments
    if (
        isset($_POST['needs_appointment']) &&
        $_POST['needs_appointment'] === 'yes' &&
        !empty($_POST['next_appointment_date']) &&
        !empty($_POST['next_appointment_time'])
    ) {

        $stmt2 = $pdo->prepare("
            INSERT INTO appointments
            (patient_id, doctor_id, status, created_at, appointment_date, appointment_time)
            VALUES (?, ?, ?, NOW(), ?, ?)
        ");

        $stmt2->execute([
            $patient_id,
            $doctor_id,
            'confirmed',
            $_POST['next_appointment_date'],
            $_POST['next_appointment_time']
        ]);
    }
// حفظ بطاقة الحمل (مرة وحدة)
if (!empty($_POST['last_period_date']) || !empty($_POST['preg_blood_type'])) {

    $check = $pdo->prepare("SELECT id FROM pregnancy_cards WHERE patient_id = ?");
    $check->execute([$patient_id]);

    if (!$check->fetch()) {
        $stmtPreg = $pdo->prepare("
            INSERT INTO pregnancy_cards (
                patient_id,
                doctor_id,
                last_period_date,
                expected_delivery_date,
                blood_type,
                pregnancies_count,
                births_count,
                miscarriages_count,
                c_sections_count,
                chronic_diseases,
                father_status,
                consanguinity,
                notes
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");

        $stmtPreg->execute([
            $patient_id,
            $doctor_id,
            $_POST['last_period_date'] ?: null,
            $_POST['expected_delivery_date'] ?: null,
            $_POST['preg_blood_type'] ?: null,
            $_POST['pregnancies_count'] ?: 0,
            $_POST['births_count'] ?: 0,
            $_POST['miscarriages_count'] ?: 0,
            $_POST['c_sections_count'] ?: 0,
            $_POST['preg_chronic_diseases'] ?: null,
            $_POST['father_status'] ?: null,
            $_POST['consanguinity'] ?: 'no',
            $_POST['pregnancy_notes'] ?: null
        ]);
    }
}

// حفظ متابعة الحمل (كل مرة row جديد)
if (!empty($_POST['preg_weight']) || !empty($_POST['fetal_heartbeat'])) {

    $stmtFollow = $pdo->prepare("
        INSERT INTO pregnancy_followups (
            patient_id,
            doctor_id,
            weight,
            blood_pressure,
            sugar_level,
            fetal_heartbeat,
            fetal_movement,
            fetal_weight,
            fetal_position,
            echo_notes,
            doctor_notes
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ");

    $stmtFollow->execute([
        $patient_id,
        $doctor_id,
        $_POST['preg_weight'] ?: null,
        $_POST['preg_blood_pressure'] ?: null,
        $_POST['preg_sugar_level'] ?: null,
        $_POST['fetal_heartbeat'] ?: null,
        $_POST['fetal_movement'] ?: null,
        $_POST['fetal_weight'] ?: null,
        $_POST['fetal_position'] ?: null,
        $_POST['echo_notes'] ?: null,
        $_POST['followup_notes'] ?: null
    ]);
}
    echo "success";
}
?>