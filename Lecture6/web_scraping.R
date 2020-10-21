#######################################################################
#  Author: Ignacio Sarmiento-Barbieri (i.sarmiento at uniandes.edu.co)
# please do not cite or circulate without permission
#######################################################################


# Clean the workspace -----------------------------------------------------
rm(list=ls())
cat("\014")
local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)}) #set repo



# Load Packages -----------------------------------------------------------
pkg<-list("rvest","tidyverse")
lapply(pkg, require, character.only=T)
rm(pkg)




# Example 1: Wikipedia's counties GDP -------------------------------------
web_page<-read_html("https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal)")


#css selector
table1<- web_page %>% 
  html_node('table.wikitable:nth-child(15) > tbody:nth-child(1) > tr:nth-child(2) > td:nth-child(1) > table:nth-child(1)') %>% 
  html_table()

#With xpath
table1b<- web_page %>% 
                    html_node(xpath="/html/body/div[3]/div[3]/div[5]/div[1]/table[3]/tbody/tr[2]/td[1]/table") %>% 
                    html_table()


# Example 2: http://books.toscrape.com/ -------------------------------------
# Inspired from https://gitlab.com/pluriza/web-scraping-with-rstudio-and-rvest/-/blob/master/webscrapingblog.R

books_page<-read_html("http://books.toscrape.com/")
books<- books_page %>% 
                    html_node("li.col-xs-6:nth-child(1) > article:nth-child(1) > h3:nth-child(3) > a:nth-child(1)") %>% 
                    html_table()
#doesn't work, it is not a table!!!


#get some atributes from the first book
node<-books_page %>%  html_node("li.col-xs-6:nth-child(1) > article:nth-child(1) > h3:nth-child(3) > a:nth-child(1)")
node_text<-html_text(node)
node_links<-html_attr(node, "href")
node_links


#Let's go into the first page
book_page<-read_html(paste0("http://books.toscrape.com/",node_links))

#Book's name
name<- book_page %>% html_node("h1") %>% html_text()
name

#Book's price
price<-book_page %>%  html_node("p.price_color") %>% html_text()
price


#Review as number
reviews_node<-book_page %>% html_node("p.star-rating")
reviews_text<-html_attr(reviews_node, "class")
reviews_text = substr(reviews_text, 13, 17)
reviews_number = switch(reviews_text, "Zero" = 0,"One" = 1, "Two" = 2, "Three" = 3, "Four" = 4, "Five" = 5,)
reviews_number

#book details result
one_book = c(name, price, reviews_number)
one_book

#extracting product details table
#PRODUCT DETAIL
details_selector = ".table"
details_node<- book_page %>%html_node(".table") %>% html_table


#get links to all books in page
links<-books_page %>% html_nodes("article > h3 > a") %>% html_attr("href")


#delay
Sys.sleep(30)

#con wget, make sure to have wget install (brew install)
link<-lista de links
system(paste0("'wget",link,"'")
