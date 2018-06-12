VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmInsertaFecha 
   Caption         =   "Inserta Fecha"
   ClientHeight    =   2475
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   2415
   OleObjectBlob   =   "frmInsertaFecha.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "frmInsertaFecha"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdCancel_Click()

    Unload Me

End Sub

Private Sub cmdFechaInicial_Click()

    frmCalendario.Show

End Sub

Private Sub cmdok_Click()
    
    Inserta_Fecha_Horizonte (Me.txtFechaInicial.Value)
    Unload Me

End Sub

Private Sub UserForm_Click()

End Sub
