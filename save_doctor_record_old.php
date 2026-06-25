<?php
session_start();
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $doctor_id = $_SESSION['user_id'];
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

    echo "success";
}
?>