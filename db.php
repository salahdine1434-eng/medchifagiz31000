<?php
// ═══════════════════════════════════════════════════════════════
//  MedChifaGiz — Configuration base de données
//  Lit les identifiants depuis les variables d'environnement
//  (définies dans Render → Environment, ou dans un .env local
//  chargé par votre serveur). Des valeurs par défaut permettent
//  de continuer à fonctionner en local avec un MySQL classique.
// ═══════════════════════════════════════════════════════════════

$host   = getenv('DB_HOST')   ?: 'localhost';
$port   = getenv('DB_PORT')   ?: '3306';
$dbname = getenv('DB_NAME')   ?: 'medchifagiz';
$user   = getenv('DB_USER')   ?: 'root';
$pass   = getenv('DB_PASS')   ?: '';

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
