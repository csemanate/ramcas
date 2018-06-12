VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmCarga_E_Historial 
   Caption         =   "Cargar Inventarios"
   ClientHeight    =   1320
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   3375
   OleObjectBlob   =   "frmCarga_E_Historial.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "frmCarga_E_Historial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub cmdAceptar_Click()

    If Me.optOtraFecha = True Then
        Unload Me
        'Carga el formulario donde se decide si sólo cargar a fecha o sólo cargar a historial en determinada fecha.
        frmCarga_O_Historial.Show
    Else
        Unload Me
        NOVIS
        'Subrutina que carga los inventarios en la de HOY
        Carga_Inventario_HOY
        Carga_Entradas_Salidas
        SIVIS
    End If
    
End Sub

Private Sub cmdCancelar_Click()
Unload Me
End Sub

Private Sub UserForm_Click()

End Sub
