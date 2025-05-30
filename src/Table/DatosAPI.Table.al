table 50401 "AMM Datos API"
{
    DataClassification = ToBeClassified;
    
    fields
    {   
        field(1;ID; Integer){}
        field(2;Nombre;Text[100]){}
        field(3;CorreoElectronico;Text[200]){}
        field(4;Telefono;Text[100]){}
        field(5;NombreEmpresa;Text[100]){}
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}