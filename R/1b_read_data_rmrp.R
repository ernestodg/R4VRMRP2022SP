# Read data 2022
# function

r4v_pull_xlsdata <- function(data)
  
{

  activityinfo::activityInfoLogin("fayolle@unhcr.org", "126c199a4206a96f62a3d4f88e996c33")
  
  df5W <- data
  
  # format column names for easier data processing
  
  colnames(df5W) <- c("Country",
                      "Admin1",
                      "Admin2",
                      "Appealing_org",
                      "Implementation",
                      "Implementing_partner",
                      "Month",
                      "Subsector",
                      "Indicator",
                      "Activity_Name",
                      "Activity_Description",
                      "RMRPActivity",
                      "COVID19",
                      "CVA",
                      "Value",
                      "Delivery_mechanism",
                      "Quantity_output",
                      "Total_monthly",
                      "New_beneficiaries",
                      "IN_DESTINATION",
                      "IN_TRANSIT",
                      "Host_Communities",
                      "PENDULARS",
                      "Returnees",
                      "Girls",
                      "Boys",
                      "Women",
                      "Men",
                      "Other_under",
                      "Other_above")
  
  # Short data wrangling for integer values
  
  df5W <<- df5W %>%
    mutate_at(c("Value",
                "Quantity_output",
                "Total_monthly",
                "New_beneficiaries",
                "IN_DESTINATION",
                "IN_TRANSIT",
                "Host_Communities",
                "PENDULARS",
                "Returnees",
                "Girls",
                "Boys",
                "Women",
                "Men",
                "Other_under",
                "Other_above"), as.numeric)%>%
    arrange(Country, Month)%>%
    replace_with_na_all(condition = ~.x == "")
  
  dfadmin1  <<- queryTable("ct51c85kxeqpu473",
                           "Country" = "c8u26b8kxeqpy0k4",
                           "Admin1" = "c3ns3zikxeqq4h95",
                           "ISOCode" = "cl3sspjkxeqq8yq6",truncate.strings = FALSE)%>%
    rowwise()%>%
    mutate(countryadmin1 = paste(Country, Admin1))%>%
    ungroup()
  
  dfadmin2 <<- read_excel("./docs/Admin2SHP.xlsx")%>%
    select(Country, Admin1, Admin2)%>%
    rowwise()%>%
    mutate(admin1and2 = paste(Admin1, Admin2))%>%
    ungroup()
  
  dfindicator  <<- queryTable("c49gyhmktedz4uj2",
                              "Code" = "cob8rivktedzp0f3",
                              "Subsector" = "cgdeh97ktn4sdek3s.cfvkmslkpy3tg94n",
                              "Indicator" = "cwkj9p4kteeh4ls5",
                              "Indicatortype" = "cprepl2ktk2l76a3", truncate.strings = FALSE)
  
  dfindSP <<- queryTable("cqt45yktk2m8ky3",
                         "Codigo" = "cob8rivktedzp0f3",
                         "SectorSP" = "c84rjfckxgbve582",
                         "Indicador" = "cwkj9p4kteeh4ls5", 
                         "Indicatortype" = "cprepl2ktk2l76a3",truncate.strings = FALSE)%>%
    rowwise()%>%
    mutate(sectindic = paste(SectorSP, Indicador))%>%
    ungroup  
  
  dfAO  <<- queryTable("cbisyyxkumvyhy57",
                       "AOIDORG" = "cnhvpo4kumvyqla8",
                       "Name" = "ckj5zamkumvyysv9",
                       "Nombre" = "cpmcp88kumvz7bsa", truncate.strings = FALSE)
  
  dfIP  <<- queryTable("cuy0fjukumwabck4",
                       "IPID" = "cd2ow0jkumwazdl1h",
                       "Name" = "ckj5zamkumvyysv9",
                       "Nombre" = "cpmcp88kumvz7bsa", truncate.strings = FALSE)
  
  return(df5W)
  
}


