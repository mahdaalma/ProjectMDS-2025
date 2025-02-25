# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(RPostgreSQL)
library(DBI)
library(DT)
library(bs4Dash)
library(dplyr)
library(plotly)
library(tidyverse)
library(rvest)
library(shinythemes)
#shinyUI(
  #dashboardPage(
    #dashboardHeader(),
    #dashboardSidebar(),
    #dashboardBody()
  #)
#)
#==========================USER INTERFACE (FRONT-END)===============================#

fluidPage(
  dashboardPage(
    #---------------------------PART HEADER----------------------------------#
    dashboardHeader(
      title =div(
        img(src = "topi.jpg", height = 60, width = 60),
        
        style = "font-size:28px; color:#ffffff; font-weight:bold; 
         text-align:center; background-color:#0073e6; 
         padding:10px; border-radius:8px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2);"
      ),
      
      dropdownMenu(type = "messages",
                   messageItem(
                     from = "statHub",
                     message = "selamat datang!, Temukan informasi jurusan statistika di seluruh Indonesia!",
                     icon = icon("globe",type="fas") #ikon globe untuk skala nasional
                   ),
                   messageItem(
                     from = "Berita Kampus",
                     message = "Cek update terbaru tentang acara dan prestasi kampus!",
                     icon = icon("newspaper", type = "fas") #ikon koran untuk berita
                   ),
                   messageItem(
                     from = "Beasiswa",
                     message = "Jelajahi peluang beasiswa!",
                     icon = icon("money-bill-wave", type = "fas") # Ikon uang untuk beasiswa
                   )
      
      )
    ),
    
    
    #-----------------------------PART SIDEBAR--------------------------------#
    
    sidebar = dashboardSidebar(
  collapsed = FALSE,
  width = 220, # Sedikit diperlebar agar teks tidak terlalu padat
  style = "background-color: #C1E3FC; font-size:15px; font-weight:bold; padding: 10px; border-radius: 8px;",
  
  sidebarMenu(
    menuItem(
      text = "Beranda",
      tabName = "beranda",
      icon = icon("home") # Ikon beranda
    ),
    
    menuItem(
      text = "Nama Universitas",
      tabName = "nama_univ",
      icon = icon("university") # Ikon universitas
    ),
    
    menuItem(
      text = "Lokasi Universitas",
      tabName = "lokasi_univ",
      icon = icon("map-marker-alt") # Ikon lokasi
    ),
    
    menuItem(
      text = "Pendaftar",
      tabName = "pendaftar",
      icon = icon("users") # Ikon orang (user)
    ),
    
    menuItem(
      text = "Galeri Universitas",
      tabName = "galeri_univ",
      icon = icon("images") # Ikon galeri foto
    ),
    
    menuItem(
      text = "Info Universitas",
      tabName = "info_univ",
      icon = icon("info-circle") # Ikon informasi
    )
  )
),


    #------------------------- PART BODY----------------------------------------#
    body = dashboardBody(
      tabItems(
        #-------------------------Tab Beranda-------------------------#
        tabItem(
          tabName = "beranda",
          div(
            style = "position: relative; background: linear-gradient(to right, #2193b0, #6dd5ed); padding: 50px; border-radius: 10px; text-align: center;",
            
            # Logo StatHub
            img(src = "topi.jpg", height = 200, width = 200, style = "margin-bottom: 20px;"),
            
            # Judul utama portal
            tags$h1("StatHub: Portal Informasi Jurusan Statistika di Indonesia",
                    style = "font-size:45px; color: white; font-weight:bold; text-shadow: 2px 2px 5px rgba(0,0,0,0.5);"),
            
            # Subjudul dengan efek mesin ketik
            tags$p(id = "typing-text",
                   style = "font-size:20px; color: #FFEA00; font-weight:bold; margin-bottom: 20px;"),
            
            # Tambahkan JavaScript untuk efek mesin ketik yang berulang setiap 5 detik
            tags$script(HTML("
      var text = 'Temukan informasi lengkap mengenai jurusan Statistika di berbagai perguruan tinggi di Indonesia. Dari akreditasi, jenjang studi, hingga peluang beasiswa.';
      var i = 0;
      
      function typeWriter() {
        if (i < text.length) {
          document.getElementById('typing-text').innerHTML += text.charAt(i);
          i++;
          setTimeout(typeWriter, 50); // Kecepatan mengetik (50ms)
        } else {
          setTimeout(resetTyping, 5000); // Tunggu 5 detik sebelum mulai ulang
        }
      }
      
      function resetTyping() {
        document.getElementById('typing-text').innerHTML = ''; // Hapus teks
        i = 0; 
        typeWriter(); // Mulai ulang efek mengetik
      }

      window.onload = typeWriter; // Jalankan saat halaman dimuat
    ")),
            
            # Tombol navigasi
            actionButton("explore_statistika", "🔍 Jelajahi Informasi",
                         onclick = "window.open('https://pddikti.kemdikbud.go.id/', '_blank')",
                         style = "background-color: #0073e6; color: white; font-size:18px; padding:12px 20px; border-radius:5px; font-weight:bold; box-shadow: 2px 2px 5px rgba(0,0,0,0.5);")
          ),
        ),
        
        #--------------------------Tab Lokasi Universitas--------------------------#
        tabItem(
          tabName = "lokasi_univ",
          fluidRow(
            tags$h1("Pencarian Universitas berdasarkan Provinsi", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          
          box(
            title = "Cari Universitas berdasarkan Provinsi yang Kamu pilih",solidHeader = TRUE,status="primary",
            uiOutput("filter_1"),
            width = 12
          ),
          box( title = "Hasil Pencarian",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl1"),
               width = 12
          )
        ),
        #------------------------Tab Nama Universitas---------------------------#
        tabItem(
          tabName = "nama_univ",
          fluidRow(
            tags$h1("Detail Prodi Berdasarkan Universitas", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          
          fluidRow(
            box(
              title = "Pilih Universitas",solidHeader = TRUE,status="primary",
              uiOutput("filter_2"),
              width = 6
            ),
            box(
              title = "Pilih Jenjang",solidHeader = TRUE,status="primary",
              uiOutput("filter_3"),
              width = 6
            ),
          ),
          fluidRow(
            box(
              title = "Pilih Universitas yang Ingin Dibandingkan",solidHeader = TRUE,status="primary",
              uiOutput("filter_6"),
              width = 6
            ),
            box(
              title = "Pilih Jenjang",solidHeader = TRUE,status="primary",
              uiOutput("filter_7"),
              width = 6
            ),
          ),
          
          box( title = "Hasil Pencarian",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl_combined"),
               width = 12
          ),
          fluidRow(
            box( title = "Barchart Jumlah Mahasiswa",solidHeader = TRUE,status="primary",
                 
                 plotlyOutput("bar_chart1"),
                 width = 6
            ),
            box( title = "Barchart Jumlah Dosen",solidHeader = TRUE,status="primary",
                 
                 plotlyOutput("bar_chart2"),
                 width = 6
            ),
          ),
          box(
            title = "Keterangan Akreditasi",
            solidHeader = TRUE,
            status = "primary",
            div(
              tags$p("Penilaian Peringkat Akreditasi Program Studi berdasarkan:"),
              tags$ul(
                tags$li("Unggul"),
                tags$p("Predikat Unggul diberikan BAN-PT kepada perguruan tinggi yang mendapat nilai akreditasi A dan memenuhi syarat 
             masuk predikat Unggul atau strata tertinggi dalam akreditasi."),
                tags$li("Baik Sekali"),
                tags$p("Predikat Baik Sekali diberikan oleh BAN-PT kepada perguruan tinggi yang mendapat nilai akreditasi A namun belum 
             memenuhi seluruh syarat predikat Unggul."),
                tags$li("Baik"),
                tags$p("Predikat Baik diberikan kepadapa perguruan tinggi yang mencapai nilai akreditasi B dengan nilai akreditasi di atas 
             200 poin."),
                tags$li("A"),
                tags$p("Akreditasi A menunjukkan nilai akreditasi antara 361-400 poin."),
                tags$li("B"),
                tags$p("Akreditasi B menunjukkan nilai akreditasi antara 301-360 poin."),
                tags$li("C"),
                tags$p("Akreditasi C dengan nilai akreditasi antara 200-300 poin.")
              ),
              style = "background-color: #C1E3FC;color: black;font-size:15px;text-align: justify; padding: 10px; border-radius: 5px;"
            ),
            width = 12,
            collapsible = TRUE,
            collapsed = TRUE 
          )
        ),
        
        #-------------------------------Tab Pendaftar--------------------------------#
        tabItem(
          tabName = "pendaftar",
          fluidRow(
            tags$h1("Jalur Pendaftaran Tiap Universitas", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          
          fluidRow(
            box(
              title = "Pilih Universitas",solidHeader = TRUE,status="primary",
              uiOutput("filter_4"),
              width = 6
            ),
            box(
              title = "Pilih Jalur",solidHeader = TRUE,status="primary",
              uiOutput("filter_5"),
              width = 6
            ),
          ),
          fluidRow(
            box(
              title = "Pilih Universitas yang Ingin Dibandingkan",solidHeader = TRUE,status="primary",
              uiOutput("filter_8"),
              width = 6
            ),
            box(
              title = "Pilih Jalur",solidHeader = TRUE,status="primary",
              uiOutput("filter_9"),
              width = 6
            ),
          ),
          
          box( title = "Hasil Pencarian",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl_combined2"),
               width = 12
          ),
          fluidRow(
            box( title = "Barchart Daya Tampung Mahasiswa",solidHeader = TRUE,status="primary",
                 
                 plotlyOutput("bar_chart3"),
                 width = 12
            ),
          )
        ),
        
        #--------------------------Tab Galeri Universitas--------------------------#
        tabItem(
          tabName = "galeri_univ",
          fluidRow(
            tags$h1("Gallery Universitas Prodi Statistika di Indonesia", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          fluidRow(
            box(
              title = "Universitas Negeri Makassar", solidHeader = TRUE, status = "primary", width = 3,
              div(
                img(src = "UNM.jpg", height = 200, width = 200), 
                tags$a(href="https://unm.ac.id/", "info detail"), 
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Padang",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNP.jpg", height = 200, width = 200), 
                tags$a(href="https://unp.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Mulawarman",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNMUL.jpg", height = 200, width = 200), 
                tags$a(href="https://unmul.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Gorontalo",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "GORONTALO.jpg", height = 200, width = 200), 
                tags$a(href="https://www.ung.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Institut Teknologi Kalimantan",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "ITK.jpg", height = 200, width = 200), 
                tags$a(href="https://itk.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Riau",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNRI.jpg", height = 200, width = 200), 
                tags$a(href="https://unri.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Lambung Mangkurat",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNLAM.jpg", height = 200, width = 200), 
                tags$a(href="https://ulm.ac.id/id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Bengkulu",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNIB.png", height = 200, width = 200), 
                tags$a(href="https://www.unib.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Tanjungpura",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNTAN.jpg", height = 200, width = 200), 
                tags$a(href="https://untan.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Cendrawasih",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "CENDRAWASIH.png", height = 200, width = 200), 
                tags$a(href="https://www.uncen.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Tadulako",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "TADULAKO.jpg", height = 200, width = 200), 
                tags$a(href="https://untad.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Halo Oleo",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "HALU_OLEO.jpg", height = 200, width = 200), 
                tags$a(href="https://uho.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Hassanudin",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNHAS_REKTORAT.jpg", height = 200, width = 200), 
                tags$a(href="https://www.unhas.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Patimura",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNRAM.jpg", height = 200, width = 200), 
                tags$a(href="https://unpatti.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Sekolah Tinggi Ilmu Statistika",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "STIS.jpg", height = 200, width = 200), 
                tags$a(href="https://www.stis.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Terbuka Tangerang",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UT.jpg", height = 200, width = 200), 
                tags$a(href="https://www.ut.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Padjajaran",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNPAD.jpg", height = 200, width = 200), 
                tags$a(href="https://www.unpad.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Institut Pertanian Bogor",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "IPB.jpg", height = 200, width = 200), 
                tags$a(href="https://www.ipb.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Semarang",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNNES.jpg", height = 200, width = 200), 
                tags$a(href="https://unnes.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Diponegoro",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNDIP.png", height = 200, width = 200), 
                tags$a(href="https://www.undip.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Indonesia",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UI.jpg", height = 200, width = 200), 
                tags$a(href="https://www.ui.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Institut Teknologi Sepuluh November",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "ITS.jpg", height = 200, width = 200), 
                tags$a(href="https://www.its.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Sebelas Maret",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNS.jpg", height = 200, width = 200), 
                tags$a(href="https://uns.ac.id/id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Jakarta",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNJ.jpg", height = 200, width = 200), 
                tags$a(href="https://www.unj.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Airlangga",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNAIR.jpg", height = 200, width = 200), 
                tags$a(href="https://unair.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Negeri Yogyakarta",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UNY.jpg", height = 200, width = 200), 
                tags$a(href="https://www.uny.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Sumatera Utara",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "USU.jpg", height = 200, width = 200), 
                tags$a(href="https://www.usu.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Gajah Mada",solidHeader = TRUE,status="primary", width = 3,
              div(
                img(src = "UGM.jpg", height = 200, width = 200), 
                tags$a(href="https://ugm.ac.id/id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
          fluidRow(
            box(
              title = "Universitas Syiah Kuala",solidHeader = TRUE,status="primary", width = 6,
              div(
                img(src = "UNSYIAH.png", height = 200, width = 200), 
                tags$a(href="https://usk.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Universitas Brawijaya",solidHeader = TRUE,status="primary", width = 6,
              div(
                img(src = "UNBRAW.png", height = 200, width = 200), 
                tags$a(href="https://ub.ac.id/", "info detail"),
                style = "text-align: center;"
              ),
              style = "display: flex; justify-content: center; align-items: center;"
            ),
          ),
        ),
        #--------------------------Tab Info Universitas--------------------------#
        tabItem(
          tabName = "info_univ",
          fluidRow(
            tags$h1("Info Pengembang Situs", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #C1E3FC; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          fluidRow(
            box(
              title = "Haiii, Kami Kelompok 2!",solidHeader = TRUE,status="primary", width = 3,
              img(src = "fotokel2.jpg", height = 220, width = 200), style = "display: flex; justify-content: center; align-items: center;"
            ),
            box(
              title = "Yuk kenalan dengan kita!!",solidHeader = TRUE,status="primary", width =9,
              tags$p("Situs ini dibuat dengan cinta oleh kelompok 2 yang merupakan projek praktikum mata kuliah Manajemen Data Statistika (STA1582) dari Program Studi Statistika dan Sains Data Pascasarjana IPB University."),  
              tags$h3("Kontributor :"),
              tags$ul(
                tags$li("Logananta Puja Kusuma sebagai Database Manager"),
                tags$li("Destriana Aulia Rifaldi sebagai Back-end Developer"),
                tags$li("Mauizatun Hasanah sebagai Front-end Developer"),
                tags$li("Mahda Al Maida sebagai Technical Writer"),
                tags$li("Yani Prihantini Hiola. sebagai Designer Database"),style = "font-size:17px;"
              ),
              tags$p("Info lebih lanjut mengenai projek database ini dapat diakses di github pengembang."),
              tags$a(href="https://github.com/mahdaalma/ProjectMDS-2025", "link github")
            ),
            
          )
        )
      )
    ),
    #-----------------FOOTER-----------------#
    
    footer = dashboardFooter(
      right = "© 2024 Kelompok 2",
      
      
    )
  )
)
