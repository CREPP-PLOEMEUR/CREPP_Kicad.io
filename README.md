# Organisation de la bibliothèque

![Capture d'écran 1](resources/Git_flowchart.png)

# Installation d'une bibliothèque via le PCM de KiCad

Ce tutoriel explique comment installer une bibliothèque à partir d'un fichier JSON via le Plugin and Content Manager (PCM) de KiCad.

## Pré-requis

- Avoir installé **KiCad 8** ou une version compatible avec le PCM.
- Disposer de l'adresse du fichier JSON de la bibliothèque :  
  `https://raw.githubusercontent.com/CREPP-PLOEMEUR/CREPP_Kicad/refs/heads/main/repository.json`

---

## Étape 1 : Ouvrir le Plugin and Content Manager (PCM)

1. Lancez **KiCad**.
2. Dans le menu principal, cliquez sur **Preferences** > **Manage Plugins**.

![Capture d'écran 1](resources/PCM1.png)

---

## Étape 2 : Ajouter un dépôt personnalisé

1. Dans la fenêtre du PCM, cliquez sur l'onglet **Gérer**.
![Capture d'écran 2](resources/PCM2.png)
2. Cliquez sur le bouton **Add** pour ajouter un nouveau dépôt.
![Capture d'écran 3](resources/PCM3.png)

---

## Étape 3 : Saisir l'URL du dépôt

1. Collez l'adresse suivante dans le champ dédié :  
   `https://raw.githubusercontent.com/CREPP-PLOEMEUR/CREPP_Kicad/refs/heads/main/repository.json`
2. Cliquez sur **OK** pour valider.
![Capture d'écran 4](resources/PCM4.png)
3. Puis faire **Enregistrer**
![Capture d'écran 5](resources/PCM5.png)

---

## Étape 4 : Mettre à jour les bibliothèques

1. Sélectionnez la bibliothèque **Kicad_repository** dans la liste déroulante
![Capture d'écran 6](resources/PCM6.png)
2. Cliquez sur le bouton **Plugins** puis **Installer**

![Capture d'écran 7](resources/PCM7.png)

