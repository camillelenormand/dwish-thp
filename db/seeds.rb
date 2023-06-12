# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#  category

Category.delete_all
Item.delete_all
Order.delete_all
Cart.delete_all
User.delete_all

 Category.create!(name: "Dwish 🥪")        #id=1
 Category.create!(name: "Salades 🥬")       #id=2
 Category.create!(name: "Accompagnements 🍟") #id=3
 Category.create!(name: "Desserts 🧁")      #id=4
 Category.create!(name: "Boissons 🥤")     #id=5



#category Dwish
 Item.create!(name: "LA POULE SAUCEE",description:"Baguette au levain (Ludivine), Poulet fermier rôti (Label Rouge), Comte affine 12 mois, radis, roquette , oignons frits, coriandre, oignons pickles & mayo maison" , price:8.50, quantity:1000 , category_id:1   ) 
 Item.create!(name: "LE BEEFTON",description:"Bun brioché, Rôti de Boeuf Charolais, Sauce béarnaise maison , oeuf dur fermier, Roquette, Oignons pickles" , price:9.50, quantity:1000 , category_id:1   )
 Item.create!(name: "Le Méchant Bagnard",description:"Véritable pan bagnat by Ludivine, Filet de Thon, Filets d’anchois, Œuf dur fermier, Tomates variétés anciennes, Radis, Céleris, Cebette, Olives noires, Basilic frais, Huile d’olive Provence." , price:9.50, quantity:1000 , category_id:1   ) 
 Item.create!(name: "LE PARIGOT",description:"Baguette craquante au levain by Ludivine, Jambon blanc Label Rouge by Maison Payany (sans nitrite), Beurre AOP Poitou-Charoute demi-sel, pickles cornichon maison (supplément comté AOP 12 mois - 1,5€)" , price:8.50, quantity:1000 , category_id:1   ) 
 Item.create!(name: "COMMIS D'OFFICE",description:"Pain Brioché by Ludivine, Avocat, Remoulade de carottes et choux rouge au citron et tahini (sésame), Crème de Feta AOP aux herbes, Amandes grillées, Mesclun" , price:8.50, quantity:1000 , category_id:1   ) 	  

#category SALADES
 Item.create!(name: "SALADE STAND BANH MI",description:"Laitue, Quinoa, Carotte, Concombre, Cebette, Coriandre, Blanc de poulet, cacahuètes , Sauce maison (Option vegan possible)" , price:9.00, quantity:1000 , category_id:2   )
 
#category ACCOMPAGNEMENT
 Item.create!(name: "SALADE STAND",description:"Laitue, Quinoa, Carotte, Concombre, Cebette, Coriandre, Blanc de poulet, cacahuètes , Sauce maison (Option vegan possible)" , price:5.00, quantity:1000 , category_id:3  )
 Item.create!(name: "CRUDICROC'",description:"Assortiments de légumes frais à croquer et tremper dans une sauce maison toute fraiche (labneh aux herbes ou houmous))" , price:5.00, quantity:1000 , category_id:3   )
 Item.create!(name: "CHIPS ARTISANALES - FAMILY CHIPS 40g",description:"Sachet individuel 40g" , price:2.50, quantity:1000 , category_id:3   )
 Item.create!(name: "CHIPS ARTISANALES - FAMILY CHIPS 125g",description:"Sachet individuel 125g" , price:4.50, quantity:1000 , category_id:3   )
 Item.create!(name: "CHIPS ARTISANALES PIMENT D'ESPELETTE - FAMILY CHIPS",description:"Sachet individuel 125g" , price:5.00, quantity:1000 , category_id:3   )
 Item.create!(name: "CHIPS ARTISANALES PIMENT TRUFFE - FAMILY CHIPS",description:"Sachet individuel 125g" , price:5.50, quantity:1000 , category_id:3   )
 
 
#category DESSERT
 Item.create!(name: "PANACOTTA VANILLE - COULIS DE FRUITS FRAIS",description:"Pannacotta vanille maison et son coulis de fruits frais au choix : Fruits rouges OU Fruits exotiques." , price:4.50, quantity:1000 , category_id:4   )
 Item.create!(name: "COMPOTE MAISON DE SAISON",description:"Compote pomme & fraise (Printemps)." , price:3.50, quantity:1000 , category_id:4   )	
 Item.create!(name: "COOKIE CHOCOLAT LAIT - PEANUT BUTTER & CACAHUETES ",description:"Cookie moelleux chocolat lait 40% Valrhona, Peanut butter et cacahuètes entières." , price:3.50, quantity:1000 , category_id:4   )	
 Item.create!(name: "COOKIE CHOCOLAT NOIR - NOISETTES TORREFIEES",description:"Cookie moelleux vanille, chocolat noir 65% Valrhona et noisettes entières torréfiées." , price:3.50, quantity:1000 , category_id:4   )	
 Item.create!(name: "Cake marbré / rocher",description:"Cake marbré chocolat vanille et sa couverture rocher chocolat lait et eclats de noutagine." , price:3.50, quantity:1000 , category_id:4   )	 
 Item.create!(name: "Tigré chocolat",description:"Financier tigré chocolat et fourré pâte à tartiner à la noisette et éclats de nougatine." , price:3.50, quantity:1000 , category_id:4   )
 Item.create!(name: "Sundae Fior Di Latte - Cookie & Choco",description:"Financier tigré chocolat et fourré pâte à tartiner à la noisette et éclats de nougatine." , price:5.00, quantity:1000 , category_id:4   )
 Item.create!(name: "Sundae Fior Di Latte - Caramel & Nougatine",description:"Crème glacée minute Fior Di Latte, Caramel Beurre salé & éclats de nougatine." , price:5.00, quantity:1000 , category_id:4   )
  

#category BOISSONS
 Item.create!(name: "Citronnade Bio - 25cl",description:"Boissonerie de Paris - Btl 25cl" , price:3.50, quantity:1000 , category_id:5   )
 Item.create!(name: "Thé glacé Bio -  Thé noir & Yuzu - 25cl" ,description:"Boissonerie de Paris - Btl 25cl", price:3.50, quantity:1000 , category_id:5   )
 Item.create!(name: "Infusion glacée Bio - Hibiscus - 25cl" ,description:"Boissonerie de Paris - Btl 25cl" , price:3.50, quantity:1000 , category_id:5   )
 Item.create!(name: "Jus de Pomme Fraise Bio btl 25 cl" ,description:"Marque : Le Coq Toqué. C’est un savant mélange de jus de pommes françaises (90%) et de jus de fraises (10%) toutes issues de l'agriculture biologique qui vous procurera une belle sensation fruitée et acidulée.",  price:4.00, quantity:1000 , category_id:5   )
 Item.create!(name: "Nectar d'Abricot du Roussillon Bio btl 25 cl" ,description:"Marque : Le Coq Toqué. Des abricots du Roussillon, rouge orangé, veloutés, sucrés et légèrement acidulés, issus de l'agriculture biologique, tendrement réduits en purée et adoucis au sucre de canne.",  price:4.00, quantity:1000 , category_id:5   )
 Item.create!(name: "Jus d'ananas bio du togo btl 25 cl" ,description:"Marque : Le Coq Toqué. Cette boisson est 100 % pur jus d’ananas, cultivé au Togo par un groupement de petits producteurs 100 % en agriculture biologique.",  price:4.00, quantity:1000 , category_id:5   )
 Item.create!(name: "Cola Bio" ,description:"UMA - Btl 33cl",  price:3.50, quantity:1000 , category_id:5   )
 Item.create!(name: "Limonade Bio" ,description:"UMA - Btl 33cl",  price:3.50, quantity:1000 , category_id:5   )
 Item.create!(name: "Ginger Beer Bio" ,description:"UMA - Btl 33cl",  price:3.50, quantity:1000 , category_id:5   )
 Item.create!(name: "Eau minérale plate 808 (Aix)" ,description:"Btl 40cl",  price:3.00, quantity:1000 , category_id:5) 
 Item.create!(name: "Eau minérale pétillante 808 (Aix)" ,description:"Btl 40cl",  price:3.00, quantity:1000 , category_id:5) 
 Item.create!(name: "Bière Tiboulen (blonde)" ,description:"Brasserie Zoumai - Btl 33 cl",  price:4.50, quantity:1000 , category_id:5)  
 Item.create!(name: "Bière Maïre (IPA)" ,description:"Brasserie Zoumai - Btl 33 cl" , price:4.50, quantity:1000 , category_id:5) 
 Item.create!(name: "Bière Gaby (blanche Combawa) " ,description:"Brasserie Zoumai - Btl 33 cl" , price:4.50, quantity:1000 , category_id:5) 


 #creation User
 User.create!(email: "test1@test.com", password: "test1@test.com")
