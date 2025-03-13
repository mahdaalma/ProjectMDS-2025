# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(shiny)
library(fontawesome)
fa_metadata()$icon_names
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

ui <- fluidPage(
  dashboardPage(
    #---------------------------PART HEADER----------------------------------#
    dashboardHeader(
      title =div(
        img(src = "logo.jpg", height = 60, width = 60),
        
        style = "font-size:28px; color:#ffffff; font-weight:bold; 
         text-align:center; background-color:#0047BB; 
         padding:10px; border-radius:8px; box-shadow: 0px 4px 8px rgba(0,0,0,0.2);"
      )
    ),
    #-----------------------------PART SIDEBAR--------------------------------#
    
    sidebar = dashboardSidebar(
      collapsed = FALSE,
      width = 220,
      style = "background-color: #0A74DA, #1E3A8A; color: white; font-size:15px; font-weight:bold; padding: 10px; border-radius: 8px;",
      
      sidebarMenu(
        menuItem(
          text = "Beranda",
          tabName = "beranda",
          icon = icon("home") # Ikon beranda
        ),
        
        menuItem(
          text = "Lokasi Universitas",
          tabName = "lokasi_univ",
          icon = icon("map-marker-alt") # Ikon lokasi
        ),
        
        menuItem(
          text = "Nama Universitas",
          tabName = "nama_univ",
          icon = icon("university") # Ikon universitas
        ),

        
        menuItem(
          text = "Pendaftaran",
          tabName = "pendaftaran",
          icon = icon("users") # Ikon orang (user)
        ),
        
        menuItem(
          text = "Website Universitas",
          tabName = "galeri_univ",
          icon = icon("images") # Ikon galeri foto
        ),
        
        menuItem(
          text = "Tentang StatLink",
          tabName = "info",
          icon = icon("info-circle") # Ikon informasi
        )
      )
    ),
    
    
    #------------------------- PART BODY----------------------------------------#
    body = dashboardBody(
      tags$head(tags$style(HTML("
    /* Ubah hanya bagian header box */
    .card-primary:not(.card-outline)>.card-header {
      background-color: #0047BB !important;
      color: white !important;
      border-color: #0047BB !important;
    }
    
    /* Sembunyikan ikon tanda tanya di navbar */
    .main-header .nav a[href*='adminlte.io/docs'] {
      display: none !important;
    }

    /* Pastikan isi box tetap putih */
    .card-primary {
      background-color: white !important;
      color: black !important;
    }

    /* Ubah warna sidebar */
    .main-sidebar {
      background: linear-gradient(180deg, #0A74DA, #1E3A8A) !important; 
      color: white !important;
    }

    /* Warna teks di sidebar */
    .sidebar-menu > li > a {
      color: white !important;
      font-size: 15px;
      font-weight: bold;
    }

    /* Warna item yang sedang aktif */
    .sidebar-menu > li.active > a {
      background-color: #0047BB !important; /* Warna untuk item aktif */
      color: white !important;
    }

    /* Warna item sidebar saat hover */
    .sidebar-menu > li > a:hover {
      background-color: #002F6C !important; /* Warna lebih gelap untuk efek hover */
      color: white !important;
    }
  "))),
      tabItems(
        #-------------------------Tab Beranda-------------------------#
        tabItem(
          tabName = "beranda",
          div(
            style = "position: relative; background: linear-gradient(to right, #0047BB,#F4A900); padding: 30px; border-radius: 10px; text-align: center;",
            
            # Logo StatHub
            img(src = "logo.jpg", height = 200, width = 200, style = "margin-bottom: 20px;"),
            
            # Judul utama portal
            tags$h1("StatLink: Portal Informasi Jurusan Statistika di Indonesia",
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
          ),
          # Informasi Pendidikan & Beasiswa
          fluidRow(
            column(
              width = 6,
              div(
                style = "background: linear-gradient(to right, #E63E82, #7B3EC8); 
               padding: 25px; border-radius: 15px; 
               display: flex; align-items: center; justify-content: space-between;
               color: white; font-weight: bold; font-size: 18px; 
               box-shadow: 2px 2px 10px rgba(0,0,0,0.2); 
               margin: 20px; height: 120px;",
                
                # Teks Informasi Pendidikan Tinggi
                div(
                  style = "flex: 1; padding: 10px;",
                  tags$p("Ada kendala terkait data Pendidikan Tinggi?", 
                         style = "font-size: 22px; margin-bottom: 5px; margin-top: 10px;"),
                  tags$p("Cari informasi ", 
                         tags$a("di sini!", href = "https://pddikti.kemdikbud.go.id/", 
                                style = "color: #FFEA00; text-decoration: none; font-weight: bold;"))
                ),
                
                # Ikon Lampu
                div(
                  style = "flex: 0; padding-right: 20px;",
                  tags$i(class = "fa fa-lightbulb", style = "font-size: 55px; color: rgba(255,255,255,0.8);")
                )
              )
            ),
            
            column(
              width = 6,
              div(
                style = "background: linear-gradient(to right, #FF7B00, #FF4500); 
               padding: 25px; border-radius: 15px; 
               display: flex; align-items: center; justify-content: space-between;
               color: white; font-weight: bold; font-size: 18px; 
               box-shadow: 2px 2px 10px rgba(0,0,0,0.2); 
               margin: 20px; height: 120px;",
                
                # Teks Informasi Beasiswa
                div(
                  style = "flex: 1; padding: 10px;",
                  tags$p("Jelajahi peluang beasiswa!", 
                         style = "font-size: 22px; margin-bottom: 5px; margin-top: 10px;"),
                  tags$p("Informasi lengkap ", 
                         tags$a("di sini!", href = "https://www.lpdp.kemenkeu.go.id/", 
                                style = "color: #FFEA00; text-decoration: none; font-weight: bold;"))
                ),
                
                # Ikon Beasiswa (Uang)
                div(
                  style = "flex: 0; padding-right: 20px;",
                  tags$i(class = "fa fa-money-bill-wave", style = "font-size: 55px; color: rgba(255,255,255,0.8);")
                )
              )
            )
          ),
          # Frequently Asked Questions (FAQ) dengan onClick (Collapsible)
          fluidRow(
            column(
              width = 8, offset = 2,
              div(
                style = "background-color: #f9f9f9; padding: 30px; border-radius: 15px; 
               box-shadow: 2px 2px 10px rgba(0,0,0,0.1); margin: 20px; text-align: center;",
                
                tags$h3("📩 Frequently Asked Questions (FAQ)", 
                        style = "color: #333; font-weight: bold; margin-bottom: 20px;"),
                
                tags$div(
                  style = "font-size: 18px; color: #444; text-align: left;",
                  
                  # Pertanyaan 1 (Collapsible)
                  tags$button(
                    class = "btn btn-light",
                    style = "width: 100%; text-align: left; font-weight: bold; margin-bottom: 5px;",
                    "1. Apa itu jurusan Statistika?",
                    `data-toggle` = "collapse", `data-target` = "#faq1"
                  ),
                  div(id = "faq1", class = "collapse", 
                      tags$p("Jurusan Statistika adalah bidang ilmu yang mempelajari cara mengumpulkan, mengolah, menganalisis, dan menyajikan data untuk mendukung pengambilan keputusan.")
                  ),
                  
                  # Pertanyaan 2 (Collapsible)
                  tags$button(
                    class = "btn btn-light",
                    style = "width: 100%; text-align: left; font-weight: bold; margin-bottom: 5px;",
                    "2. Apa saja prospek kerja lulusan Statistika?",
                    `data-toggle` = "collapse", `data-target` = "#faq2"
                  ),
                  div(id = "faq2", class = "collapse",
                      tags$p("Lulusan Statistika memiliki prospek kerja di berbagai bidang seperti analisis data, keuangan, riset pasar, aktuaria, dan ilmu data.")
                  ),
                  
                  # Pertanyaan 3 (Collapsible)
                  tags$button(
                    class = "btn btn-light",
                    style = "width: 100%; text-align: left; font-weight: bold; margin-bottom: 5px;",
                    "3. Apa perbedaan antara Statistika dan Data Science?",
                    `data-toggle` = "collapse", `data-target` = "#faq3"
                  ),
                  div(id = "faq3", class = "collapse",
                      tags$p("Statistika berfokus pada teori dan metode pengolahan data, sedangkan Data Science menggabungkan Statistika dengan pemrograman dan teknologi untuk analisis data yang lebih kompleks.")
                  ),
                  
                  # Pertanyaan 4 (Collapsible)
                  tags$button(
                    class = "btn btn-light",
                    style = "width: 100%; text-align: left; font-weight: bold; margin-bottom: 5px;",
                    "4. Universitas mana saja yang memiliki jurusan Statistika terbaik di Indonesia?",
                    `data-toggle` = "collapse", `data-target` = "#faq4"
                  ),
                  div(id = "faq4", class = "collapse",
                      tags$p("Ada banyak universitas terbaik yang memiliki program studi Statistika di Indonesia. informasi lebih lanjut kamu bisa 
                             membuka tab lokasi universitas dan dapat melihat informasi akreditasi dan ranking setiap universitas.")
                  ),
                  
                  # Pertanyaan 5 (Collapsible)
                  tags$button(
                    class = "btn btn-light",
                    style = "width: 100%; text-align: left; font-weight: bold; margin-bottom: 5px;",
                    "5. Apakah ada beasiswa untuk mahasiswa Statistika?",
                    `data-toggle` = "collapse", `data-target` = "#faq5"
                  ),
                  div(id = "faq5", class = "collapse",
                      tags$p("Ya! Banyak beasiswa tersedia untuk mahasiswa Statistika, termasuk LPDP, Beasiswa Unggulan, dan beasiswa dari kampus masing-masing.")
                  )
                )
              )
            )
          ),
        ),
        #--------------------------Tab Lokasi Universitas--------------------------#
        tabItem(
          tabName = "lokasi_univ",
          fluidRow(
            tags$h1("Pencarian Universitas", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #0047BB;color:white; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          
          box(
            title = "Cari universitas berdasarkan Provinsi",solidHeader = TRUE,status="primary",
            uiOutput("filter_1"),
            width = 12
          ),
          box( title = "Hasil Pencarian Universitas",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl1"),
               width = 12
          )
        ),
      
        #------------------------Tab Nama Universitas---------------------------#
        tabItem(
          tabName = "nama_univ",
          fluidRow(
            tags$h1("Informasi Program Studi Setiap Universitas", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #0047BB;color: white;  padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          
          fluidRow(
            box(
              title = "Pilih Universitas",solidHeader = TRUE,status="primary",
              uiOutput("filter_2"),
              width = 6
            ),
            box(
              title = "Pilih Jenjang Pendidikan",solidHeader = TRUE,status="primary",
              uiOutput("filter_3"),
              width = 6
            ),
          ),
          fluidRow(
            box(
              title = "Bandingkan Universitas",solidHeader = TRUE,status="primary",
              uiOutput("filter_6"),
              width = 6
            ),
            box(
              title = "Pilih Jenjang Pendidikan ",solidHeader = TRUE,status="primary",
              uiOutput("filter_7"),
              width = 6
            ),
          ),
          
          box( title = "Hasil Pencarian",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl_combined"),
               width = 12
          ),
          fluidRow(
            box( title = "Jumlah Mahasiswa",solidHeader = TRUE,status="primary",
                 
                 plotlyOutput("bar_chart1"),
                 width = 6
            ),
            box( title = "Jumlah Dosen",solidHeader = TRUE,status="primary",
                 
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

        #-------------------------------Tab Pendaftaran--------------------------------#
        tabItem(
          tabName = "pendaftaran",
          fluidRow(
            tags$h1("Jalur Pendaftaran di Setiap Universitas", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #0047BB;color: white;; padding: 15px; border-radius: 8px;"),
          ),
          tags$br(),
          
          fluidRow(
            box(
              title = "Pilih Universitas",solidHeader = TRUE,status="primary",
              uiOutput("filter_4"),
              width = 6
            ),
            box(
              title = "Pilih Jalur Pendaftaran",solidHeader = TRUE,status="primary",
              uiOutput("filter_5"),
              width = 6
            ),
          ),
          fluidRow(
            box(
              title = "Bandingkan Universitas",solidHeader = TRUE,status="primary",
              uiOutput("filter_8"),
              width = 6
            ),
            box(
              title = "Pilih Jalur Pendaftaran",solidHeader = TRUE,status="primary",
              uiOutput("filter_9"),
              width = 6
            ),
          ),
          
          box( title = "Hasil Pencarian",solidHeader = TRUE,status="primary",
               
               dataTableOutput("out_tbl_combined2"),
               width = 12
          ),
          fluidRow(
            box( title = "Daya Tampung Mahasiswa",solidHeader = TRUE,status="primary",
                 
                 plotlyOutput("bar_chart3"),
                 width = 12
            ),
          )
        ),
        
        #--------------------------Tab Website Universitas--------------------------#
        tabItem(
          tabName = "galeri_univ",
          
          # Header
          fluidRow(
            div(
              style = "background-color: #0047BB;color: white; padding: 20px; border-radius: 12px; text-align: center; margin-bottom: 20px; color: #0047BB; color:white",
              tags$h1("Website Universitas Jurusan Statistika di Indonesia", 
                      style = "font-size:38px; font-weight:bold; margin:0; font-family:Arial, sans-serif;")
            )
          ),
          
          tags$br(),
          
          # Galeri dalam Grid Layout 4 Kolom
          fluidRow(
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://unm.ac.id/", "Universitas Negeri Makassar", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://unp.ac.id/", "Universitas Negeri Padang", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://unmul.ac.id/", "Universitas Mulawarman", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.ung.ac.id/", "Universitas Negeri Gorontalo", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://itk.ac.id/", "Institut Teknologi Kalimantan", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://unri.ac.id/", "Universitas Riau", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://ulm.ac.id/", "Universitas Lambung Mangkurat", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://untan.ac.id/", "Universitas Tanjungpura", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.uncen.ac.id/", "Universitas Cendrawasih", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://untad.ac.id/", "Universitas Tadulako", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.unhas.ac.id/", "Universitas Hasanuddin", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://unpatti.ac.id/", "Universitas Pattimura", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.stis.ac.id/", "Sekolah Tinggi Ilmu Statistik", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.ut.ac.id/", "Universitas Terbuka Tangerang", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.unpad.ac.id/", "Universitas Padjadjaran", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.ipb.ac.id/", "Institut Pertanian Bogor", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://unnes.ac.id/", "Universitas Negeri Semarang", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.undip.ac.id/", "Universitas Diponegoro", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.ui.ac.id/", "Universitas Indonesia", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.its.ac.id/", "Institut Teknologi Sepuluh Nopember", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://uns.ac.id/id/", "Universitas Sebelas Maret", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.unj.ac.id/", "Universitas Negeri Jakarta", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://unair.ac.id/", "Universitas Airlangga", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.uny.ac.id/", "Universitas Negeri Yogyakarta", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://www.usu.ac.id/", "Universitas Sumatera Utara", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://ugm.ac.id/", "Universitas Gadjah Mada", class = "univ-link", target = "_blank")
              )
            ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(href = "https://usk.ac.id/", "Universitas Syiah Kuala", class = "univ-link", target = "_blank")
              )
              ),
            column(
              width = 4,
              div(
                class = "univ-card",
                tags$a(
                  href = "https://ub.ac.id/", 
                  "Universitas Brawijaya",
                  class = "univ-link",
                  target = "_blank"
                )
              )
            ),
          ),
          
          # Tambahkan CSS untuk mendukung tampilan
          tags$style(
            HTML("
      .univ-card {
        background-color: #FFFFFF;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
        text-align: center;
        margin: 10px;
        transition: transform 0.3s ease-in-out;
      }
      .univ-card:hover {
        transform: scale(1.05);
      }
      .univ-img {
        width: 100%;
        height: auto;
        max-height: 180px;
        border-radius: 8px;
      }
      .info-btn {
        display: inline-block;
        margin-top: 10px;
        padding: 8px 12px;
        background-color: #0073e6;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
      }
      .info-btn:hover {
        background-color: #005bb5;
      }
    ")
          )
        ),
        #--------------------------Tab Tentang StatLink--------------------------#
        tabItem(
          tabName = "info",
          fluidRow(
            tags$h1("Info Pengembang Situs", 
                    style = "font-size:40px; font-weight:bold; display: inline;
                     align-items: center; background-color: #0047BB; color:white;
                     padding: 15px; border-radius: 10px; text-align: center; width: 100%;"),
          ),
          tags$br(),
          
          # Foto Kelompok dan Deskripsi
          div(
            style = "background: white; padding: 20px; border-radius: 10px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);",
            tags$p("Situs ini dikembangkan sebagai bagian dari proyek praktikum Mata Kuliah Manajemen Data Statistika (STA1582) di Program Studi Statistika dan Sains Data Pascasarjana, IPB University. Proyek ini bertujuan untuk menyediakan platform informasi yang interaktif dan terpercaya bagi siapa saja yang ingin mengeksplorasi data terkait program studi Statistika di Indonesia."),  
            tags$h3("Tim Pengembang :"),
            tags$p("Proyek ini dikembangkan oleh Kelompok 2, dengan kontribusi dari anggota tim berikut:"),
            
            # Layout foto + nama + peran dengan header gradien
            fluidRow(
              column(4, 
                     div(
                       style = "background: white; border-radius: 10px; overflow: hidden;
                   box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);",
                       div(
                         style = "background: linear-gradient(to right, #0047BB, #F4A900); 
                     color: white; padding: 10px; text-align: center; 
                     font-weight: bold; font-size: 16px;",
                         "Database Manager"
                       ),
                       div(
                         style = "text-align: center; padding: 15px;",
                         img(src = "logan.jpg", height = 180, width = 180, 
                             style="border-radius: 8px; display: block; margin: auto;"),
                         tags$p("Logananta Puja Kusuma", 
                                style="text-align:center; font-weight:bold; margin-top:10px;")
                       )
                     )
              ),
              column(4, 
                     div(
                       style = "background: white; border-radius: 10px; overflow: hidden;
                   box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);",
                       div(
                         style = "background: linear-gradient(to right, #0047BB, #F4A900); 
                     color: white; padding: 10px; text-align: center; 
                     font-weight: bold; font-size: 16px;",
                         "Back-end Developer"
                       ),
                       div(
                         style = "text-align: center; padding: 15px;",
                         img(src = "destri.jpeg", height = 180, width = 180, 
                             style="border-radius: 8px; display: block; margin: auto;"),
                         tags$p("Destriana Aulia Rifaldi", 
                                style="text-align:center; font-weight:bold; margin-top:10px;")
                       )
                     )
              ),
              column(4, 
                     div(
                       style = "background: white; border-radius: 10px; overflow: hidden;
                   box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);",
                       div(
                         style = "background: linear-gradient(to right, #0047BB, #F4A900); 
                     color: white; padding: 10px; text-align: center; 
                     font-weight: bold; font-size: 16px;",
                         "Front-end Developer"
                       ),
                       div(
                         style = "text-align: center; padding: 15px;",
                         img(src = "iza.jpg", height = 180, width = 180, 
                             style="border-radius: 8px; display: block; margin: auto;"),
                         tags$p("Mauizatun Hasanah", 
                                style="text-align:center; font-weight:bold; margin-top:10px;")
                       )
                     )
              )
            ),
            
            fluidRow(
              column(4, 
                     div(
                       style = "background: white; border-radius: 10px; overflow: hidden;
                   box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);",
                       div(
                         style = "background: linear-gradient(to right, #0047BB, #F4A900); 
                     color: white; padding: 10px; text-align: center; 
                     font-weight: bold; font-size: 16px;",
                         "Technical Writer"
                       ),
                       div(
                         style = "text-align: center; padding: 15px;",
                         img(src = "alma.jpg", height = 180, width = 180, 
                             style="border-radius: 8px; display: block; margin: auto;"),
                         tags$p("Mahda Al Maida", 
                                style="text-align:center; font-weight:bold; margin-top:10px;")
                       )
                     )
              ),
              column(4, 
                     div(
                       style = "background: white; border-radius: 10px; overflow: hidden;
                   box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);",
                       div(
                         style = "background: linear-gradient(to right, #0047BB, #F4A900); 
                     color: white; padding: 10px; text-align: center; 
                     font-weight: bold; font-size: 16px;",
                         "Database Designer"
                       ),
                       div(
                         style = "text-align: center; padding: 15px;",
                         img(src = "yani.jpg", height = 180, width = 180, 
                             style="border-radius: 8px; display: block; margin: auto;"),
                         tags$p("Yani Prihantini Hiola", 
                                style="text-align:center; font-weight:bold; margin-top:10px;")
                       )
                     )
              )
            ),
            
            tags$p("Info lebih lanjut mengenai proyek ini dapat diakses di GitHub pengembang."),
            tags$a(href="https://github.com/mahdaalma/ProjectMDS-2025", "🔗 Link GitHub", target="_blank", 
                   style="font-size:18px; font-weight:bold; color:#0047BB; text-decoration:none;")
          )
        )
      )
      )
    ),
    #-----------------FOOTER-----------------#
  
    
    footer = dashboardFooter(
      right = "© Kelompok 2 Manajemen Data Statistika | 2025 | Statistika dan Sains Data",
      
      
    )
  )