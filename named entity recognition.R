library(rvest)
library(NLP)
Sys.setenv(JAVA_HOME='C:\\Java\\jre1.8.0_231\\bin') # set java path for include of rJava library
library(rJava)
library(openNLP)
page = read_html('https://en.wikipedia.org/wiki/Berkshire_Hathaway')

text = html_text(html_nodes(page,'p'))
text = text[text != ""]
text = gsub("\\[[0-9]]|\\[[0-9][0-9]]|\\[[0-9][0-9][0-9]]","",text) # removing refrences [101] type

# Make one complete document
text = paste(text,collapse = " ") 

text = as.String(text)

sent_annot = Maxent_Sent_Token_Annotator()
word_annot = Maxent_Word_Token_Annotator()
loc_annot = Maxent_Entity_Annotator(kind = "location") #annotate location
people_annot = Maxent_Entity_Annotator(kind = "person") #annotate person

annot.l1 = NLP::annotate(text, list(sent_annot,word_annot,loc_annot,people_annot))

k <- sapply(annot.l1$features, `[[`, "kind")
berk_locations = text[annot.l1[k == "location"]]
berk_people = text[annot.l1[k == "person"]]
all_places = unique(berk_locations)# view contents of this obj
all_places
unique(berk_people)


library(rvest)
library(NLP)
library(openNLP)
page = read_html('https://en.wikipedia.org/wiki/Berkshire_Hathaway')
text = html_text(html_nodes(page,'p'))
text = text[text != ""]
text = gsub("\\[[0-9]]|\\[[0-9][0-9]]|\\[[0-9][0-9][0-9]]","",text) # removing refrences [101] type

# Make one complete document
text = paste(text,collapse = " ") 

text = as.String(text)

sent_annot = Maxent_Sent_Token_Annotator()
word_annot = Maxent_Word_Token_Annotator()
loc_annot = Maxent_Entity_Annotator(kind = "location") #annotate location
people_annot = Maxent_Entity_Annotator(kind = "person") #annotate person

annot.l1 = NLP::annotate(text, list(sent_annot,word_annot,loc_annot,people_annot))

k <- sapply(annot.l1$features, `[[`, "kind")
berk_locations = text[annot.l1[k == "location"]]
berk_people = text[annot.l1[k == "person"]]
all_places = unique(berk_locations)# view contents of this obj
all_places
unique(berk_people)


