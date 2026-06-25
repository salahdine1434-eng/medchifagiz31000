# Déployer MedChifaGiz sur GitHub + Render

## ⚠️ 1. Sécurité — à faire AVANT toute mise en ligne

Le fichier `config/.env` original contenait une **clé Groq API en clair**
(`gsk_b5n8l...`). Cette clé a été retirée du projet, mais comme elle a
déjà été exposée (dans le fichier que vous m'avez envoyé), il faut :

1. Aller sur https://console.groq.com
2. Révoquer/supprimer cette clé et en générer une nouvelle
3. Ne jamais la remettre dans un fichier versionné — elle se configure
   uniquement dans **Render → Environment** (étape 4 ci-dessous)

`config/.env` est maintenant listé dans `.gitignore` : il ne sera jamais
poussé sur GitHub. Gardez-le uniquement en local pour vos tests.

---

## 2. Pousser le projet sur GitHub

Depuis le dossier du projet (celui que vous venez de télécharger, dézippé) :

```bash
git init
git add .
git commit -m "Initial commit - MedChifaGiz"
git branch -M main
git remote add origin https://github.com/<votre-utilisateur>/<votre-repo>.git
git push -u origin main
```

Créez d'abord le dépôt vide sur https://github.com/new (sans README, sans
.gitignore — vous les avez déjà).

---

## 3. Pourquoi un Dockerfile (et pas "yarn"/Node) ?

Ce projet est en **PHP + MySQL**, pas en Node.js. Render n'a pas de
runtime PHP natif : il faut passer par **Docker**. Le `Dockerfile` fourni :

- part de l'image officielle `php:8.2-apache`
- installe les extensions nécessaires (`pdo_mysql`, `mysqli`, `curl`, `gd`)
- copie votre code dans `/var/www/html`
- adapte automatiquement Apache au port que Render impose via `$PORT`
  (`docker-entrypoint.sh`)

Vous n'avez rien à configurer côté "Build Command" / "Start Command" :
Render détecte le `Dockerfile` et s'en sert pour tout.

---

## 4. Créer le service Web sur Render

1. https://dashboard.render.com → **New** → **Web Service**
2. Connectez votre dépôt GitHub
3. **Language / Runtime** : Docker (détecté automatiquement grâce au `Dockerfile`)
4. **Instance Type** : Free pour tester (voir limites base de données ci-dessous)
5. Dans **Advanced → Environment Variables**, ajoutez :

| Clé | Valeur |
|---|---|
| `DB_HOST` | (voir étape 5) |
| `DB_PORT` | `3306` |
| `DB_NAME` | `medchifagiz` |
| `DB_USER` | votre utilisateur MySQL |
| `DB_PASS` | votre mot de passe MySQL |
| `GROQ_API_KEY` | votre **nouvelle** clé Groq |
| `GMAIL_ADDRESS` | votre adresse Gmail d'envoi |
| `GMAIL_APP_PASSWORD` | mot de passe d'application Google (https://myaccount.google.com/apppasswords) |

6. Cliquez **Create Web Service**. Le premier build prend quelques minutes.

> Le fichier `render.yaml` inclus permet aussi de créer ce service en un
> clic via **New → Blueprint** sur Render, si vous préférez.

---

## 5. Base de données MySQL — deux options

Render ne propose pas de MySQL managé "officiel" (seulement PostgreSQL).
Deux solutions possibles :

### Option A — MySQL hébergé sur Render même (recommandé pour la fiabilité)
- Créez un **second service** : **New → Private Service**, image Docker
  existante `mysql:8` (ou suivez le guide officiel :
  https://render.com/docs/deploy-mysql)
- Attachez un **disque persistant** monté sur `/var/lib/mysql`
- ⚠️ Nécessite un plan payant (les disques persistants ne sont pas
  disponibles sur l'offre Free)
- Une fois en ligne, son adresse interne (ex. `medchifagiz-db:3306`) devient
  votre `DB_HOST`

### Option B — Base MySQL externe (pour tester gratuitement)
Des hébergeurs comme InfinityFree (celui visé à l'origine par ce projet)
bloquent généralement les connexions MySQL externes : `db.php` configuré
pour Render ne pourra pas s'y connecter depuis l'extérieur. Pour un MySQL
accessible de l'extérieur gratuitement, il faut chercher un hébergeur qui
l'autorise explicitement — l'offre gratuite change souvent, donc vérifiez
les conditions actuelles avant de stocker des données réelles. **Comme
cette application gère des données médicales, évitez les bases gratuites
non garanties pour autre chose que des tests.**

Quelle que soit l'option, importez le schéma une fois la base créée :

```bash
mysql -h <DB_HOST> -P 3306 -u <DB_USER> -p <DB_NAME> < "medchifagiz (16).sql"
```

---

## 6. Vérifications après déploiement

- Ouvrez l'URL `https://<votre-service>.onrender.com` → la page d'inscription
  (`index.html`) doit s'afficher
- Testez une inscription complète pour vérifier la connexion MySQL
- Testez l'envoi d'OTP par e-mail (vérifie `GMAIL_ADDRESS` / `GMAIL_APP_PASSWORD`)
- Testez le journal quotidien avec analyse IA (vérifie `GROQ_API_KEY`)

## 7. Limites connues à garder en tête

- Le dossier `chatbot_kh/uploads/` est **éphémère** sur le plan Free : les
  images envoyées au chatbot disparaissent à chaque redéploiement/redémarrage.
  Pour les conserver, ajoutez un disque persistant (plan payant).
- Le plan Free de Render met le service en veille après inactivité ; la
  première requête après une pause peut être lente (cold start).
