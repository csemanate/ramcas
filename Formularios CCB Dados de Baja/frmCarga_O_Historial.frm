VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmCarga_O_Historial 
   ClientHeight    =   1995
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   1890
   OleObjectBlob   =   "frmCarga_O_Historial.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "frmCarga_O_Historial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub cmdCancelar_Click()
Unload Me
End Sub

Private Sub cmdCargar_Click()
    
    'Inicia las subrutinas tradicionales que insertan el inventario físico actual en la fecha seleccionada
    Unload Me
    If Application.Calculation = xlManual Then
        Application.Calculation = xlCalculationAutomatic
    End If
    frmCargaInventarioAFecha.Show
    
End Sub

Private Sub cmdHistorial_Click()
    
    Unload Me
    'Inicia las subrutinas tradicionales que insertan los datos del día en la fecha seleccionada dentro del archivo DATOS
    CALAUTO
    frmCargaAHistorial.Show
    
End Sub

