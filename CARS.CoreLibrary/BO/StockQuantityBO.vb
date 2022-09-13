Imports System.Xml.Serialization

Public Class StockQuantityBO
    Public Property spareID As String
    Public Property alfaLev As String

    Public Property artnrLev As String

    Public Property navnLev As String

    Public Property antallLev As String

    Public Property nettoLev As String

    Public Property bruttoLev As String

    Public Property merknadLev As String

    Public Property nrLev As String

    Public Property alfaSogb As String

    Public Property artnrSogb As String

    Public Property navnSogb As String

    Public Property antallSogb As String

    Public Property noSogb As String

    Public Property bestilt As Integer

    Public Property isValid As Boolean
    ' NOTE: Generated code may require at least .NET Framework 4.5 or .NET Core/Standard 2.0.
    '''<remarks/>
    <System.SerializableAttribute(),
     System.ComponentModel.DesignerCategoryAttribute("code"),
     System.Xml.Serialization.XmlTypeAttribute(AnonymousType:=True)>
    <XmlRoot("xml")>
    Partial Public Class xmlStockQty

        Private autodataField As xmlAutodata

        '''<remarks/>
        Public Property autodata() As xmlAutodata
            Get
                Return Me.autodataField
            End Get
            Set
                Me.autodataField = Value
            End Set
        End Property
    End Class

    '''<remarks/>
    <System.SerializableAttribute(),
     System.ComponentModel.DesignerCategoryAttribute("code"),
     System.Xml.Serialization.XmlTypeAttribute(AnonymousType:=True)>
    Partial Public Class xmlAutodata

        Private lev918Field As xmlAutodataLev918

        Private sogbField As xmlAutodataSogb

        '''<remarks/>
        '''

        Public Property lev918() As xmlAutodataLev918
            Get
                Return Me.lev918Field
            End Get
            Set
                Me.lev918Field = Value
            End Set
        End Property

        '''<remarks/>
        Public Property sogb() As xmlAutodataSogb
            Get
                Return Me.sogbField
            End Get
            Set
                Me.sogbField = Value
            End Set
        End Property
    End Class

    '''<remarks/>
    <System.SerializableAttribute(),
     System.ComponentModel.DesignerCategoryAttribute("code"),
     System.Xml.Serialization.XmlTypeAttribute(AnonymousType:=True)>
    <XmlRoot("lev")>
    Partial Public Class xmlAutodataLev918

        Private postField As xmlAutodataLev918Post

        '''<remarks/>
        Public Property post() As xmlAutodataLev918Post
            Get
                Return Me.postField
            End Get
            Set
                Me.postField = Value
            End Set
        End Property
    End Class

    '''<remarks/>
    <System.SerializableAttribute(),
     System.ComponentModel.DesignerCategoryAttribute("code"),
     System.Xml.Serialization.XmlTypeAttribute(AnonymousType:=True)>
    Partial Public Class xmlAutodataLev918Post

        Private alfaField As String

        Private artnrField As String

        Private navnField As String

        Private antallField As String

        Private nettoField As String

        Private bruttoField As String

        Private merknadField As String

        Private nrField As String

        '''<remarks/>
        Public Property alfa() As String
            Get
                Return Me.alfaField
            End Get
            Set
                Me.alfaField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property artnr() As String
            Get
                Return Me.artnrField
            End Get
            Set
                Me.artnrField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property navn() As String
            Get
                Return Me.navnField
            End Get
            Set
                Me.navnField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property antall() As String
            Get
                Return Me.antallField
            End Get
            Set
                Me.antallField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property netto() As String
            Get
                Return Me.nettoField
            End Get
            Set
                Me.nettoField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property brutto() As String
            Get
                Return Me.bruttoField
            End Get
            Set
                Me.bruttoField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property merknad() As String
            Get
                Return Me.merknadField
            End Get
            Set
                Me.merknadField = Value
            End Set
        End Property

        '''<remarks/>
        <System.Xml.Serialization.XmlAttributeAttribute()>
        Public Property nr() As String
            Get
                Return Me.nrField
            End Get
            Set
                Me.nrField = Value
            End Set
        End Property
    End Class

    '''<remarks/>
    <System.SerializableAttribute(),
     System.ComponentModel.DesignerCategoryAttribute("code"),
     System.Xml.Serialization.XmlTypeAttribute(AnonymousType:=True)>
    Partial Public Class xmlAutodataSogb

        Private artField As xmlAutodataSogbArt

        '''<remarks/>
        Public Property art() As xmlAutodataSogbArt
            Get
                Return Me.artField
            End Get
            Set
                Me.artField = Value
            End Set
        End Property
    End Class

    '''<remarks/>
    <System.SerializableAttribute(),
     System.ComponentModel.DesignerCategoryAttribute("code"),
     System.Xml.Serialization.XmlTypeAttribute(AnonymousType:=True)>
    Partial Public Class xmlAutodataSogbArt

        Private alfaField As String

        Private artnrField As String

        Private navnField As String

        Private antallField As String

        Private noField As String

        '''<remarks/>
        Public Property alfa() As String
            Get
                Return Me.alfaField
            End Get
            Set
                Me.alfaField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property artnr() As String
            Get
                Return Me.artnrField
            End Get
            Set
                Me.artnrField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property navn() As String
            Get
                Return Me.navnField
            End Get
            Set
                Me.navnField = Value
            End Set
        End Property

        '''<remarks/>
        Public Property antall() As String
            Get
                Return Me.antallField
            End Get
            Set
                Me.antallField = Value
            End Set
        End Property

        '''<remarks/>
        <System.Xml.Serialization.XmlAttributeAttribute()>
        Public Property no() As String
            Get
                Return Me.noField
            End Get
            Set
                Me.noField = Value
            End Set
        End Property
    End Class
End Class



