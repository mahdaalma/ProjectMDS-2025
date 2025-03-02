library(shiny)

# Panggil file UI dan server dari folder app
source("app/ui.R")
source("app/server.R")

# Jalankan aplikasi
shinyApp(ui = ui, server = server)