<?php
// ═══════════════════════════════════════════════════════════════
//  MedChifaGiz — Configuration base de données
//  Lit les identifiants depuis les variables d'environnement
//  (définies dans Render → Environment, ou dans un .env local
//  chargé par votre serveur). Des valeurs par défaut permettent
//  de continuer à fonctionner en local avec un MySQL classique.
// ═══════════════════════════════════════════════════════════════

$host   = getenv('DB_HOST')   ?: 'sql12.freesqldatabase.com';
$port   = getenv('DB_PORT')   ?: '3306';
$dbname = getenv('DB_NAME')   ?: 'sql12831500';
$user   = getenv('DB_USER')   ?: 'sql12831500';
$pass   = getenv('DB_PASS')   ?: 'n7sJpSN8hI';

// ───────────────────────────────────────────────────────────────
//  NE PAS MODIFIER EN DESSOUS
// ───────────────────────────────────────────────────────────────
try {
    $pdo = new PDO(
        "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4",
        $user,
        $pass
    );
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("فشل الاتصال بقاعدة البيانات: " . $e->getMessage());
}
?>
