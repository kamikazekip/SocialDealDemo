
# Social deal case Erik Brandsma

![Social Deal logo](https://media.licdn.com/dms/image/v2/C4D0BAQESg5yb4W5tCA/company-logo_200_200/company-logo_200_200/0/1630493998982/social_deal_logo?e=2147483647&v=beta&t=FgfIcxJDnw3cdYxqNSd0oAkXfwtwXw52GTMZ0iEwdok)

  **Geimplementeerde features:**
Ze zitten er allemaal in!

**Gebruikte tijd**
~10 uur

**Dit wil ik graag uitlichten over de app:**

 - De app werkt op alle devices (iPhone, iPad, iPod)
 - De app werkt in alle orientaties
 - De app werkt vanaf iOS 14+ (Dezelfde versie als de Social Deal app in de App Stores)
 - De app werkt met light en dark mode. (Uitzondering is de webview omdat die HTML toont. Ik had niet genoeg tijd om een JavaScript Bridge te bouwen, maar dat had vrij simpel gekunt.)
 -  Alle network calls worden lazy gedaan. Bijvoorbeeld de plaatjes van de deals worden ingeladen terwijl je kunt blijven scrollen, wat betekend dat de app ontzettend responsive is.

**Dit wil ik graag uitlichten over de code:**

 - Er zijn geen compiler warnings
 - Alles is volledig in UIKit
 - De code is Swift 6 compile-time concurrency compliant. Mocht dit een onbekend onderwerp zijn licht ik het graag toe. Schrik vooral niet van Task { } en @MainActor code. Die is er om aan compile-time concurrency te voldoen en zorgt ervoor dat er geen racing conditions kunnen voorkomen.
 - Er zitten geen automatische tests in omdat ik simpelweg niet de tijd had.

**Gemaakte keuzes en waarom**
- Third party libraries: Ik heb geopteerd om er geen te gebruiken. Ik geloof dat dat de beste manier is zodat je niet afhankelijk bent van een update van een third party op het moment dat een nieuwe iOS versie uitkomt of er een bug blijkt te zijn.

- Storyboards VS code: Ik heb voor code gekozen omdat 1. Ik daar meer flexibiliteit ervaar, 2. Als je in een groot team werkt code duidelijker is in git applicaties en PR's

- Constraints vs UIStackView: Ik heb gekozen voor constraints omdat ik ervaar dat UIStackView vaak automagisch constraints toevoegen die conflicteren met wat ik wil bereiken. Vandaar dat ik overal simpelweg constraints heb gebruikt

- Packages: Ik heb gekozen om twee packages te maken: Domain en Networking. Dit omdat ik graag wilde laten zien dat de domeinlogica helemaal gescheiden kan zijn. Zo zou je daarmee ook heel snel een MacOS app kunnen opzetten omdat alle domeinlogica daar al in zit. Networking had ik gemaakt omdat dat een mooie afscheiding is.

- UIKit vs SwiftUI: Ik heb voor UIKit gekozen omdat de requirements zo waren. Echter heb ik het gevoel dat SwiftUI beter was geweest omdat 1: SwiftUI declarative is. Dit betekend dat de volgorde van initialiseren niet uitmaakt waar dat bij UIKit wel hevig het geval is. Dat kan leiden tot bugs als men niet voorzichtig is. En 2:  developers moeten bij UIKit bij elke wijziging het project opnieuw runnen waarbij je bij SwiftUI gebruik kan maken van handige in-IDE previews, wat enorm veel tijd scheelt.

**Gebruikte tooling:**
- Xcode 16.0 (16A242d) 
[Download hier van developer.apple.com mocht jullie Xcode versie mijn project niet kunnen draaien.](https://download.developer.apple.com/Developer_Tools/Xcode_16/Xcode_16.xip)
