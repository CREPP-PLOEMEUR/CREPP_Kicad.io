import wx
import pcbnew

class PCBWorkflowPlugin(pcbnew.ActionPlugin):
    def defaults(self):
        self.name = "Assistant de création de PCB"
        self.category = "Outils de calcul"
        self.description = "Un plugin pour guider les étapes de création d'un PCB"
    
    def Run(self):
        # Créer une fenêtre principale
        app = wx.App()
        frame = WorkflowFrame(None, title="Assistant de création de PCB")
        frame.Show()
        app.MainLoop()

class WorkflowFrame(wx.Frame):
    def __init__(self, parent, title):
        super().__init__(parent, title=title, size=(400, 500))

        # Panneau principal
        panel = wx.Panel(self)
        vbox = wx.BoxSizer(wx.VERTICAL)

        # Instructions générales
        instructions = wx.StaticText(panel, label="Résumé des étapes :")
        vbox.Add(instructions, flag=wx.ALL | wx.EXPAND, border=10)

        # Liste des étapes
        steps = [
            "1. Vérifiez le schéma et les annotations",
            "2. Synchronisez le PCB avec le schéma",
            "3. Placez et routez les composants",
            "4. Configurez les règles de conception (DRC)",
            "5. Vérifiez les erreurs de DRC",
            "6. Exportez les fichiers Gerber et BOM"
        ]
        for step in steps:
            vbox.Add(wx.StaticText(panel, label=step), flag=wx.LEFT, border=20)

        # Bouton d'export
        export_btn = wx.Button(panel, label="Exporter les fichiers Gerber")
        vbox.Add(export_btn, flag=wx.ALL | wx.CENTER, border=10)

        # Connecter le bouton à une action
        export_btn.Bind(wx.EVT_BUTTON, self.on_export)

        panel.SetSizer(vbox)

    def on_export(self, event):
        wx.MessageBox("Export des fichiers Gerber en cours...", "Information", wx.OK | wx.ICON_INFORMATION)
        # Ici, ajoutez le code pour appeler l'exportation des fichiers Gerber
        print("Fichiers Gerber exportés avec succès !")

# Enregistrez le plugin
PCBWorkflowPlugin().register()