VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmCargaInventarioAFecha 
   Caption         =   "Cargar Inventario a Fecha"
   ClientHeight    =   1215
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   2850
   OleObjectBlob   =   "frmCargaInventarioAFecha.frx":0000
   StartUpPosition =   1  'Centrar en propietario
End
Attribute VB_Name = "frmCargaInventarioAFecha"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Calendar1_CloseUp()
    
    Me.cmdok.Enabled = True
    Me.txtFecha = Format(Calendar1.Value, "dd/mm/yyyy")

End Sub

Private Sub cmdCancelar_Click()
Unload Me
End Sub

Private Sub cmdok_Click()

    'Subrutina que carga los inventarios en la fecha seleccionada en un combobox
    Carga_Inventario_En_Fecha

End Sub

Private Sub UserForm_Initialize()

    Calendar1.Value = Date
    Me.cmdok.Enabled = False

End Sub

