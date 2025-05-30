report 50401 "AMM Report Datos API"
{
    Caption = 'Report Datos API';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'layout/DatosAPIRDL.rdl';
    dataset
    {
        dataitem("AMM Datos API";"AMM Datos API")
        {
            column(ID;ID){}
            column(Nombre;Nombre){}
            column(CorreoElectronico;CorreoElectronico){}
            column(Telefono;Telefono){}
            column(NombreEmpresa;NombreEmpresa){}
        }
    }
}