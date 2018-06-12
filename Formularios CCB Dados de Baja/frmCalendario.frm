VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmCalendario 
   Caption         =   "Calendario"
   ClientHeight    =   795
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   3090
   OleObjectBlob   =   "frmCalendario.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "frmCalendario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Calendar1_CloseUp()
    If frmInsertaFecha.Visible = True Then
        frmInsertaFecha.txtFechaInicial = Format(Calendar1.Value, "dd/mm/yyyy")
    End If
    Unload Me
End Sub

Private Sub UserForm_Initialize()
    Calendar1.Value = Date
End Sub

