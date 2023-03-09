Class Medidoc.Util
{

ClassMethod MedidocToFhirDate(date As %String) As %String
{
        set year = $E(date,1,4)
        set month = $E(date,5,6)
        set day = $E(date,7,8)
        return year_"-"_month_"-"_day
}

}
