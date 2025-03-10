#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DBI)
library(RMariaDB)
library(RMySQL)

connectDB <- function() {
  DB <- dbConnect(
    MySQL(),
    dbname = "databaseuniv", 
    host = "127.0.0.1",
    user = "root",
    password = ""
  )
  return(DB)
}

#----------------------Query1--------------------------#
q1 <- paste0("
      SELECT w.nama_prov, w.nama_kabkota, u.nama_univ, u.akred_univ, u.qs_rank
      FROM wilayah w
      JOIN universitas u ON w.id_wilayah = u.id_wilayah"
)
#----------------------Query2--------------------------#
q2<-paste0("
      SELECT u.nama_univ, p.nama_prodi, p.jumlah_mahasiswa, p.jumlah_dosen, p. akred_prodi, p.jenjang
      FROM universitas u
      JOIN prodi_stathub p ON u.id_univ = p.id_univ"
)

#----------------------Query3--------------------------#
q3<-paste0("
      SELECT u.nama_univ, p.nama_prodi, j.jalur_masuk, j.daya_tampung, j.website
      FROM universitas u
      JOIN prodi_stathub p ON u.id_univ = p.id_univ
      JOIN jalur_masuk j ON p.id_prodi = j.id_prodi"
)

DB <- connectDB()

# Eksekusi query jika koneksi berhasil
if (!is.null(DB)) {
  tabel01 <- data.frame(dbGetQuery(DB, q1))
  tabel02 <- data.frame(dbGetQuery(DB, q2))
  tabel03 <- data.frame(dbGetQuery(DB, q3))
  dbDisconnect(DB)
} else {
  message("Koneksi ke database gagal!")
}

#==========================SERVER(BACK-END)===============================#
server <- function(input, output) {
  
  #----------------Tab Cari Provinsi-----------------#
  output$filter_1 <- renderUI({
    selectInput(
      inputId = "nama_prov_filter",
      label = "Silakan Pilih Provinsi",
      multiple = TRUE,
      choices = tabel01$nama_prov)
  })
  
  data1 <- reactive({
    tabel01 %>% filter(nama_prov %in% input$nama_prov_filter)
  })
  
  output$out_tbl1 <- renderDataTable({
    data1()
  })
  
  #----------------Tab Cari Univ------------------#
  output$filter_2 <- renderUI({
    selectInput(
      inputId = "nama_univ_filter",
      label = "Silakan Pilih Universitas",
      multiple = FALSE,
      choices = tabel02$nama_univ)
  })
  
  output$filter_3 <- renderUI({
    req(input$nama_univ_filter)
    selectInput(
      inputId = "jenjang_filter",
      label = "Pilih Jenjang Studi",
      multiple = FALSE, 
      choices = sort(unique(tabel02$jenjang[tabel02$nama_univ %in% input$nama_univ_filter]))
    )
  })
  
  output$filter_6 <- renderUI({
    selectInput(
      inputId = "nama_univ_filter2",
      label = "Silakan Pilih Universitas",
      multiple = FALSE,
      choices = tabel02$nama_univ)
  })
  
  output$filter_7 <- renderUI({
    req(input$nama_univ_filter2)
    selectInput(
      inputId = "jenjang_filter2",
      label = "Pilih Jenjang Studi",
      multiple = FALSE, 
      choices = sort(unique(tabel02$jenjang[tabel02$nama_univ %in% input$nama_univ_filter2]))
    )
  })
  
  # Menyimpan tanggal pencarian untuk universitas
  data_combined <- reactive({
    data2 <- tabel02 %>%
      filter(nama_univ %in% input$nama_univ_filter,
             jenjang %in% input$jenjang_filter) %>%
      mutate(tanggal = Sys.Date())  # Menambahkan tanggal pencarian
    
    data4 <- tabel02 %>%
      filter(nama_univ %in% input$nama_univ_filter2,
             jenjang %in% input$jenjang_filter2) %>%
      mutate(tanggal = Sys.Date())  # Menambahkan tanggal pencarian
    
    combined_data <- rbind(data2, data4)
    return(combined_data)
  })
  
  output$out_tbl_combined <- renderDataTable({
    datatable(data_combined(), options = list(pageLength = 10))
  })
  
  output$bar_chart1 <- renderPlotly({
    data_filtered <- data_combined()
    
    plot_ly(data_filtered, x = ~nama_univ, y = ~jumlah_mahasiswa, type = 'bar', color = "red",
            text = ~jumlah_mahasiswa, 
            insidetextanchor = 'start', 
            insidetextfont = list(color = 'navy')) %>% 
      layout(title = "Jumlah Mahasiswa tiap Universitas",
             xaxis = list(title = "Nama Universitas"),
             yaxis = list(title = "Jumlah Mahasiswa", range=c(0,500)))
  })
  
  output$bar_chart2 <- renderPlotly({
    data_filtered <- data_combined()
    
    plot_ly(data_filtered, x = ~nama_univ, y = ~jumlah_dosen, type = 'bar', color = "red",
            text = ~jumlah_dosen, 
            insidetextanchor = 'start', 
            insidetextfont = list(color = 'navy')) %>% 
      layout(title = "Jumlah Dosen tiap Universitas",
             xaxis = list(title = "Universitas"),
             yaxis = list(title = "Jumlah Dosen", range=c(0,500)))
  })
  
  #--------------------Tab Daftar------------------#
  output$filter_4 <- renderUI({
    selectInput(
      inputId = "nama_univ_filter1",
      label = "Silakan Pilih Universitas",
      multiple = FALSE,
      choices = tabel03$nama_univ)
  })
  
  output$filter_5 <- renderUI({
    selectInput(
      inputId = "jalur_filter",
      label = "Pilih Jalur Masuk",
      multiple = FALSE,
      choices = sort(unique(tabel03$jalur_masuk[tabel03$nama_univ %in% input$nama_univ_filter1]))
    )
  })
  
  output$filter_8 <- renderUI({
    selectInput(
      inputId = "nama_univ_filter3",
      label = "Silakan Pilih Universitas",
      multiple = FALSE,
      choices = tabel03$nama_univ)
  })
  
  output$filter_9 <- renderUI({
    req(input$nama_univ_filter3)
    selectInput(
      inputId = "jalur_filter2",
      label = "Pilih Jalur Masuk",
      multiple = FALSE, 
      choices = sort(unique(tabel03$jalur_masuk[tabel03$nama_univ %in% input$nama_univ_filter3]))
    )
  })
  
  # Menyimpan tanggal pencarian untuk daftar universitas
  data_combined2 <- reactive({
    data3 <- tabel03 %>%
      filter(nama_univ %in% input$nama_univ_filter1,
             jalur_masuk %in% input$jalur_filter) %>%
      mutate(tanggal = Sys.Date())  # Menambahkan tanggal pencarian
    
    data5 <- tabel03 %>%
      filter(nama_univ %in% input$nama_univ_filter3,
             jalur_masuk %in% input$jalur_filter2) %>%
      mutate(tanggal = Sys.Date())  # Menambahkan tanggal pencarian
    
    combined_data2 <- rbind(data3, data5)
    return(combined_data2)
  })
  
  output$out_tbl_combined2 <- renderDataTable({
    datatable(data_combined2(), options = list(pageLength = 10))
  })
  
  output$bar_chart3 <- renderPlotly({
    data_filtered <- data_combined2()
    
    plot_ly(data_filtered, x = ~nama_univ, y = ~daya_tampung, type = 'bar', color = "red",
            text = ~daya_tampung, 
            insidetextanchor = 'start', 
            insidetextfont = list(color = 'navy')) %>% 
      layout(title = "Daya Tampung Universitas",
             xaxis = list(title = "Universitas"),
             yaxis = list(title = "Daya Tampung", range=c(0,500)))
  })
  
  # Render DataTable untuk Ditampilkan
  output$tabel_univ <- DT::renderDataTable({
    datatable(data_univ(), options = list(pageLength = 10))
  })
  
  # Tutup koneksi database saat aplikasi ditutup
  onStop(function() {
    dbDisconnect(con)
  })
}
