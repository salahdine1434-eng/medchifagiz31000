<?php
session_start();
require 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'] ?? 0;
    $status = $_POST['status'] ?? '';

    $allowed = ['completed', 'no_show', 'confirmed', 'cancelled'];

    if (!$id || !in_array($status, $allowed)) {
        exit('error');
    }

    $stmt = $pdo->prepare("UPDATE appointments SET status = ? WHERE id = ?");
    $stmt->execute([$status, $id]);

    echo 'success';
}
?>