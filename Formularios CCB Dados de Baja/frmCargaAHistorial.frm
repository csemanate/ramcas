VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmCargaAHistorial 
   Caption         =   "Cargar Historial a Fecha"
   ClientHeight    =   1215
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   2850
   OleObjectBlob   =   "frmCargaAHistorial.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "frmCargaAHistorial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Calendar1_CloseUp()
    
    Me.cmdok.Enabled = True
    Me.txtFecha = Format(Calendar1.Value, "dd/mm/yyyy")

End Sub

Private Sub cmdCancelar_Click()
    Unload Me
End Sub

Private Sub cmdok_Click()
    
Dim fechaseleccionada As String

    'Asigna el valor a la fecha
    fechaseleccionada = Me.txtFecha.Value
    Unload Me
    NOVIS
    'Subrutina que carga los datos al Historial en una fecha escogida
    Carga_Datos_Historial (fechaseleccionada)
    'Subrutina que carga los datos del historial del Maestro de ítems de Agrota en una fecha escogida
    'Carga_Datos_Historial_Maestro_WISE
    SIVIS
    
End Sub
Private Sub UserForm_Initialize()

    Calendar1.Value = Date
    Me.cmdok.Enabled = False

End Sub

