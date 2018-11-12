var state_arr = new Array("Andaman and Nicobar Islands","Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chandigarh","Chhattisgarh","Dadra and Nagar Haveli","Daman and Diu","Delhi","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Lakshadweep","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Puducherry","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttarakhand","West Bengal","NA");
var s_a = new Array();
s_a[0]="";

s_a[1]="Port Blair|other";
s_a[2] = "Adoni|Amalapuram|Anakapalle|Anantapur|Bapatla|Bheemunipatnam|Bhimavaram|Bobbili|Chilakaluripet|Chirala|Chittoor|Dharmavaram|Eluru|Gooty|Gudivada|Gudur|Guntakal|Guntur|Hindupur|Jaggaiahpet|Jammalamadugu|Kadapa|Kadiri|Kakinada|Kandukur|Kavali|Kovvur|Kurnool|Macherla|Machilipatnam|Madanapalle|Mandapeta|Markapur|Nagari|Nandyal|Narasapuram|Narasaraopet|Narsipatnam|Nellore|Nidadavole|Nuzvid|Ongole|Palacole|Palasa Kasibugga|Parvathipuram|Pedana|Peddapuram|Pithapuram|Ponnur|Proddatur|Punganur|Puttur|Rajahmundry|Rajam|Rajampet|Ramachandrapuram|Rayachoti|Rayadurg|Renigunta|Repalle|Salur|Samalkot|Sattenapalle|Srikakulam|Srikalahasti|Srisailam|Sullurpeta|Tadepalligudem|Tadpatri|Tanuku|Tenali|Tirupati|Tiruvuru|Tuni|Uravakonda|Venkatagiri|Vijayawada|Vinukonda|Visakhapatnam|Vizianagaram|Yemmiganur|Yerraguntla|other";
s_a[3]="Itanagar|Naharlagun|Pasighat|other";
s_a[4]="Barpeta|Bongaigaon City|Dhubri|Dibrugarh|Diphu|Goalpara|Guwahati|Jorhat|Karimganj|Lanka|Lumding|Mangaldoi|Mankachar|Margherita|Mariani|Marigaon|Nagaon|Nalbari|North Lakhimpur|Rangia|Sibsagar|Silapathar|Silchar|Tezpur|Tinsukia|other";
s_a[5]="Araria|Arrah|Arwal|Asarganj|Aurangabad|Bagaha|Barh|Begusarai|Bettiah|Bhabua|Bhagalpur|Bihar|Buxar|Chapra|Darbhanga|Dehri-on-Sone|Dumraon|Forbesganj|Gaya|Gopalganj|Hajipur|Jamalpur|Jamui|Jehanabad|Kalol|Katihar|Khagaria|Kishanganj|Lakhisarai|Lalganj|Madhepura|Madhubani|Maharajganj|Mahnar Bazar|Makhdumpur|Maner|Manihari|Marhaura|Masaurhi|Mirganj|Mokameh|Motihari|Motipur|Munger|Murliganj|Muzaffarpur|Narkatiaganj|Naugachhia|Nawada|Nokha|Patna|Phulwari Sharif|Piro|Purnia|Rafiganj|Rajgir|Ramnagar|Raxaul Bazar|Revelganj|Rosera|Saharsa|Samastipur|Sasaram|Sheikhpura|Sheohar|Sherghati|Silao|Sitamarhi|Siwan|Sonepur|Sugauli|Sultanganj|Supaul|Warisaliganj|other";
s_a[6]="Chandigarh|other";
s_a[7]="Ambikapur|Bhatapara|Bhilai|Bhilai Charoda|Bhilai Nagar|Bilaspur|Chirmiri|Dalli-Rajhara|Dhamtari|Durg|Jagdalpur|Korba|Mahasamund|Manendragarh|Mungeli|Naila Janjgir|Raigarh|Raipur|Rajnandgaon|Sakti|Tilda Newra|other";
s_a[8]="Silvassa|other";
s_a[9]="Daman|Diu|other";
s_a[10]="Delhi|New Delhi|other";
s_a[11]="Mapusa|Margao|Marmagao|Panaji|other";
s_a[12]="Adalaj|Ahmedabad|Amreli|Anand|Anjar|Ankleshwar|Bardoli|Bharuch|Bhavnagar|Bhuj|Bilimora|Chandkheda|Dahod|Deesa|Dhoraji|Gandhidham|Gandhinagar|Ghatlodiya|Godhra|Gondal|Himatnagar|Jamnagar|Jetpur|Junagadh|Kadi|Kapadvanj|Keshod|Khambhat|Lathi|Limbdi|Lunawada|Mahesana|Mahuva|Manavadar|Mandvi|Mangrol|Mansa|Mehmedabad|Modasa|Morvi|Nadiad|Navsari|Padra|Palanpur|Palitana|Pardi|Patan|Petlad|Porbandar|Radhanpur|Rajkot|Rajpipla|Rajula|Ranavav|Rapar|Salaya|Sanand|Savarkundla|Sidhpur|Sihor|Songadh|Surat|Talaja|Thangadh|Tharad|Umbergaon|Umreth|Una|Unjha|Upleta|Vadnagar|Vadodara|Valsad|Vapi|Veraval|Vijapur|Viramgam|Visnagar|Vyara|Wadhwan|Wankaner|other";
s_a[13]="Ambala|Ambala Cantonment| Ambala Sadar|Bahadurgarh|Bhiwani|Charkhi Dadri|Faridabad|Fatehabad|Gohana|Gurgaon|Hansi|Hisar| Jagadhri|Jind|Kaithal|Karnal|Kurukshetra|Ladwa|Mahendragarh|Mandi Dabwali|Narnaul|Narwana|Palwal|Panchkula|Panipat|Pehowa|Pinjore|Rania|Ratia|Rewari|Rohtak|Safidon|Samalkha|Sarsod|Shahbad|Sirsa|Sohna|Sonipat|Taraori|Thanesar|Tohana|Yamunanagar|other";
s_a[14]="Mandi|Nahan|Shimla|Solan|Sundarnagar|other";
s_a[15]="Anantnag|Baramula|Jammu|Kathua|Punch|Rajauri|Sopore|Srinagar|Udhampur|other";
s_a[16]="Adityapur|Bagbera|Bokaro Steel City|Bhuli|Chaibasa|Chakradharpur|Chas|Chatra|Chirkunda|Medininagar|Daltonganj |Deoghar|Dhanbad|Dumka|Giridih|Gumia|Hazaribag|Jamshedpur|Jharia|Jhumri Tilaiya|Katras|Lohardaga|Madhupur|Mango|Mihijam|Musabani|Pakaur|Patratu|Phusro|Ramgarh|Ranchi|Sahibganj|Saunda|Simdega|Tenu dam-cum-Kathhara|other";
s_a[17]="Adyar|Afzalpur|Arsikere|Athni|Bagalkot|Bangalore|Belgaum|Bellary|  Bhadravati|Bidar| Bijapur|Bommanahalli|Byatarayanapura| Chikballapur|Chikmagalur|Chitradurga|Dasarahalli|Davanagere|Gadag|Gangawati|Gokak|Gulbarga| Hassan|Haveri|Hospet|Hubli-Dharwad|Karwar|Kolar|Koppal|Krishnarajapura|Lakshmeshwar|Lingsugur|Maddur|Madhugiri|Madikeri|Magadi|Mahadevapura|Mahalingapura|Malavalli|Malur|Mandya|Mangalore|Manvi|Mudalagi|Mudabidri|Muddebihal|Mudhol|Mulbagal|Mundargi|Mysore|Nanjangud| Nipani|Pavagada|Piriyapatna|Puttur|Rabkavi Banhatti|Raayachuru|Ranebennuru|Ramanagaram|Ramdurg|Ranibennur|Robertson Pet|Ron|Sadalagi|Sagara|Sakaleshapura|Sindagi|Sandur|Sankeshwara|Saundatti-Yellamma|Savanur|Sedam|Shahabad|Shahpur|Shiggaon|Shikaripur| Shimoga|Shivamogga|Surapura|Shrirangapattana|Sidlaghatta|Sindhagi|Sindhnur|Sira|Sirsi|Siruguppa|Srinivaspur|Talikota|Tarikere|Tekkalakote|Terdal|Talikota|Tiptur|Tumkur|Udupi|Vijayapura|Wadi|Yadgir|Yelahanka|other";
s_a[18]="Adoor|Alappuzha| Beypore|Chalakudy|Changanassery|Changanacheri|Cherthala| Cheruvannur| Chittur-Thathamangalam|Edathala| Guruvayoor|Kalamassery| Kanhangad|Kannur| Kasaragod| Kayamkulam|Kochi| Kodungallur| Kollam| Kottayam| Kozhikode|Kunnamkulam| Malappuram| Mattannur|Mavelikkara|Mavoor|Muvattupuzha|Manjeri| Nedumangad|Neyyattinkara|Nilambur|Ottappalam|Palai|Palakkad| Panamattom|Panniyannur|Pappinisseri|Paravoor|Pathanamthitta|Peringathur|Perinthalmanna|Perumbavoor|Payyannur| Ponnani|Punalur|Puthuppally|Quilandi|Shoranur|Taliparamba|Thalassery|Thiruvalla|Thiruvananthapuram|Thodupuzha|Thrippunithura| Thrissur| Tirur| Tiruvalla| Vadakara|Vaikom|Varkala|other";
s_a[19]="Kavaratti|other";
s_a[20]="Ashok Nagar|Balaghat| Betul| Bhind|Bhopal|Bina-Etawa| Burhanpur| Chhatarpur| Chhindwara| Damoh|Dewas| Dhar|Ganjbasoda|Guna| Gwalior| Harda| Hoshangabad|Indore|Itarsi| Jabalpur| Jabalpur Cantonment| Khandwa| Khargone|Lahar|Maharajpur|Mahidpur|Maihar|Malaj Khand|Manasa|Manawar|Mandideep|Mandla| Mandsaur|Mauganj|Mhow|Mhowgaon|Morena|Multai|Mundi|Murwara| Nagda|Nainpur|Narsimhapur|Narsinghgarh|Neemuch| Nepanagar|Niwari|Nowgong|Nowrozabad (Khodargama)|Pachore|Pali|Panagar|Pandhurna|Panna|Pasan|Pipariya|Pithampur|Porsa|Prithvipur|Raghogarh-Vijaypur|Rahatgarh|Raisen|Rajgarh|Ratlam|Rau| Rewa|Rehli|Rewa|Sabalgarh|Sanawad|Sagar|Sarangpur|Sarni|Satna|Sausar|Sehore|Sendhwa|Seoni|Seoni-Malwa|Shahdol| Shajapur|Shamgarh|Shivpuri| Sheopur|Shivpuri|Shujalpur|Sidhi|Sihora|Singrauli|Sironj|Sohagpur|Tarana|Tikamgarh|Tikamgarh| Ujjain|Umaria|Vidisha|Vijaypur|Wara Seoni|other";
s_a[21]="Achalpur|Ahmadnagar| Akola| Akot|Amarnath|Amalner|Ambejogai|Amravati| Anjangaon|Arvi|Aurangabad| Badlapur| Baramati| Bhiwandi|Bhusawal| Chandrapur| Dhule| Dombivali| Ichalkaranji|Jalgaon| Jalna| Kalyan| Karjat|Karad| Khopoli| Kolhapur|Latur|Loha|Lonar|Lonavla|Lonavale|Mahad|Malegaon|Malkapur|Mangalvedhe|Mangrulpir|Manjlegaon|Manmad|Manwath|Mehkar|Mhaswad|Mira Bhayandar|Morshi|Mukhed|Mul|Murtijapur|Nagpur|Nalasopara| Nanded|Nandgaon|Nandura|Nandurbar|Narkhed|Nashik| Navi Mumbai|Nawapur|Nilanga|Osmanabad|Ozar|Pachora|Paithan|Palghar|Pandharkaoda|Pandharpur|Panvel|Parbhani|Panvel|Parli|Parola|Partur|Parbhani|Pathardi|Pathri|Patur|Pauni|Pen|Phaltan|Pimpri-Chinchwad|Pulgaon|Pune Cantonment|Purna|Pusad|Rahuri|Rajura|Ramtek|Ratnagiri|Raver|Risod|Sailu|Sangamner|Sangli (-Miraj)|Sangole|Sasvad|Satana|Satara| Savner|Sawantwadi|Solapur| Shahade|Shegaon|Shendurjana|Shirdi|Shirpur-Warwade|Shirur|Shrigonda|Shrirampur|Sillod|Sinnar|Solapur|Soyagaon|Talegaon Dabhade|Talode|Tasgaon|Thane|Tirora|Tuljapur|Tumsar|Uchgaon|Udgir|Umarga|Umarkhed|Umred|Uran|Uran Islampur|Ulhasnagar|Vadgaon Kasba|Vaijapur|Vasai|Virar|Vita|Wardha|Wadgaon Road|Wai|Wani|Warora|Warud|Washim|Yavatmal|Yawal|Yevla|Yavatmal|other";
s_a[22]="Imphal|Lilong|Mayang Imphal|Thoubal|other";
s_a[23]="Nongstoin|Shillong|Tura|other";
s_a[24]="Aizawl|Lunglei|Saiha|other";
s_a[25]="Dimapur|Kohima|Mokokchung|Tuensang|Wokha|Zunheboto|other";
s_a[26]="Balangir| Baleshwar| Barbil|Bargarh| Baripada| Bhadrak| Bhawanipatna| Bhubaneswar|Brahmapur| Byasanagar|Brajarajnagar| Cuttack| Dhenkanal| Jatani|Jaypur| Jharsuguda|Kendrapara|Kendujhar|Malkangiri|Nabarangapur|Paradip| Parlakhemundi|Pattamundai|Phulabani|Puri|Rairangpur|Rajagangapur|Raurkela Township| Rayagada| Sambalpur|Soro|Sundargarh| Sunabeda|Talcher|Tarbha|Titlagarh|other";
s_a[27]="Karaikal|Mahe|Pondicherry|Yanam|other";
s_a[28]="Abohar|Amritsar|Barnala|Batala|Bathinda|Dhuri|Faridkot|Fazilka|Firozpur|Firozpur Cantt.|Gobindgarh|Gurdaspur|Hoshiarpur|Jagraon|Jalandhar Cantt.|Jalandhar|Kapurthala|Khanna|Kharar|Kot Kapura|Longowal|Ludhiana|Malerkotla|Malout|Mansa|Moga|Mohali|Morinda|Mukerian|Muktsar|Nabha|Nakodar|Nangal|Nawanshahr|Pathankot|Patiala|Patran|Patti|Phagwara|Phillaur|Qadian|Raikot|Raikot|Rajpura|Rampura Phul|Rupnagar|S.A.S. Nagar|Samana|Sangrur|Sirhind Fatehgarh Sahib| Sirhind|Sujanpur|Sunam|Talwara|Tarn Taran|Urmar Tanda|Zira|Zirakpur|other";
s_a[29]="Ajmer| Alwar | Balotra|Banswara|Baran|Barmer|Beawar|Bharatpur|Bhilwara| Bikaner | Bundi|  Chittaurgarh|Chomun|Churu| Dausa|Dhaulpur| Fatehpur|Ganganagar|Hanumangarh|Jaipur |Jaisalmer| Jhunjhunun|Jodhpur|  Karauli|Kishangarh|Kota|Lachhmangarh | Ladnu | Lakheri | Lalsot | Losal | Makrana | Malpura | Mandalgarh | Mandawa | Mangrol | Merta City | Mount Abu | Nadbai | Nagar | Nagaur| Nargund| Nasirabad | Nathdwara| Navalgund | Neem-Ka-Thana|Nelamangala|Nimbahera|Nohar|Nokha|Pali|Phalodi|Phulera|Pilani|Pilibanga|Pindwara|Pipar City|Prantij|Pratapgarh|Raisinghnagar|Rajakhera|Rajaldesar|Rajgarh (Alwar)|Rajgarh (Churu)|Rajsamand|Ramganj Mandi|Ramngarh|Ratangarh|Rawatbhata|Rawatsar|Reengus|Sadri|Sadulshahar|Sadulpur|Sagwara|Sambhar|Sanchore|Sangaria|Sardarshahar|Sawai Madhopur|Shahpura|Shahpura|Sheoganj|Sikar|Sirohi|Sojat|Sri Madhopur|Sujangarh|Sumerpur|Suratgarh|Taranagar|Todabhim|Todaraisingh|Tonk|Udaipur|Udaipurwati|Vijainagar|other";
s_a[30]="Gangtok|other";
s_a[31]="Alandur|Ambattur|Arakonam|Avadi|Chennai|Chengalpattu| Chidambaram|Coimbatore|Coonoor| Cuddalore|Dharmapuri|Dindigul|Erode|Gobichettipalayam| Hosur|Kancheepuram|Karur| Krishnagiri|Kumbakonam|Lalgudi|Madavaram|Madurai| Mayiladuthurai|Nagapattinam|Nagercoil|Namagiripettai|Namakkal|Nandivaram-Guduvancheri|Nanjikottai|Natham|Nellikuppam|Neyveli (TS)|O' Valley|Oddanchatram|P.N.Patti|Pacode|Padmanabhapuram|Palani|Palladam|Pallapatti|Pallikonda|Panagudi|Panruti|Paramakudi|Parangipettai|Pattukkottai|Perambalur|Peravurani|Periyakulam|Periyasemur|Pernampattu|Pollachi|Polur|Ponneri|Pudukkottai|Pudupattinam|Puliyankudi|Punjaipugalur|Ranipet|Rajapalayam|Ramanathapuram|Rameshwaram|Rasipuram|Salem|Sankarankoil|Sankari|Sathyamangalam|Sattur|Shenkottai|Sholavandan|Sholingur|Sirkali|Sivaganga|Sivagiri|Sivakasi|Srivilliputhur|Surandai|Suriyampalayam|Tambaram|Tenkasi|Thammampatti|Thanjavur|Tharamangalam|Tharangambadi|Theni Allinagaram|Thirumangalam|Thirupuvanam|Thiruthuraipoondi|Thiruvallur|Thiruvarur|Thoothukkudi|Thuraiyur|Tindivanam|Tirndur|Tiruchengode|Tiruchirappalli|Tirukalukundram|Tirukkoyilur|Tirunelveli|Tirupathur|Tirupathur|Tirupathur|Tiruppur|Tiruttani|Tiruvannamalai|Tiruvethipuram|Tittakudi|Udhagamandalam|Udumalaipettai|Unnamalaikadai|Usilampatti|Uthamapalayam|Uthiramerur|Vadakkuvalliyur|Vadalur|Vadipatti|Valparai|Vandavasi|Vaniyambadi|Vedaranyam|Vellakoil|Vellore|Vikramasingapuram|Viluppuram|Virudhachalam|Virudhunagar|Viswanatham|other";
s_a[32]="Adilabad|Bellampalle|Bhadrachalam|Bhainsa|Bhongir|Bodhan|Farooqnagar|Gadwal|Hyderabad|Jagtial|Jangaon|Kagaznagar|Kamareddy|Karimnagar|Khammam|Koratla|Kothagudem|Kyathampalle|Mahbubnagar|Mancherial|Mandamarri|Manuguru|Medak|Miryalaguda|Nagarkurnool|Narayanpet|Nirmal|Nizamabad|Palwancha|Ramagundam|Sadasivpet|Sangareddy|Siddipet|Sircilla|Suryapet|Tandur|Vikarabad|Wanaparthy|Warangal|Yellandu|other";
s_a[33]="Agartala|Pratapgarh|Udaipur|other";
s_a[34]="Agra|Aligarh|Allahabad|Amroha|Azamgarh|Bahraich|Bareilly| Behta Hajipur|Bijnor|Bulandshahr|Chandausi|Dadri|Etawah|Firozabad|Farrukhabad|Fatehpur Sikri|Ghaziabad|Gonda|Gorakhpur|Hapur|Jaunpur|Jhansi|Kalpi|Kanpur|Laharpur|Lakhimpur|Lal Gopalganj Nindaura|Lalitpur|Lalganj|Lar|Loni|Lucknow| Mathura|Meerut|Mirzapur|Modinagar|Moradabad|Muzaffarnagar|Nagina|Najibabad|Nakur|Nanpara|Naraura|Naugawan Sadat|Nautanwa|Nawabganj|Nehtaur|Niwai|Noida|Noorpur|Obra|Orai|Padrauna|Palia Kalan|Parasi|Phulpur|Pihani|Pilibhit|Pilkhuwa|Powayan|Pukhrayan|Puranpur|Purquazi|Purwa|Rae Bareli|Rampur|Rampur Maniharan|Rampur Maniharan|Rasra|Rath|Renukoot|Reoti|Robertsganj|Rudauli|Rudrapur|Sadabad|Safipur|Saharanpur|Sahaspur|Sahaswan|Sahawar|Sahjanwa|Saidpur|Sambhal|Samdhan|Samthar|Sandi|Sandila|Sardhana|Seohara|Shahabad| Hardoi|Shahabad| Rampur|Shahganj|Shahjahanpur|Shamli|Shamsabad| Agra|Shamsabad| Farrukhabad|Sherkot|Shikarpur| Bulandshahr|Shikohabad|Shishgarh|Siana|Sikanderpur|Sikandra Rao|Sikandrabad|Sirsaganj|Sirsi|Sitapur|Soron|Suar|Sultanpur|Sumerpur|Tanda|Thakurdwara|Thana Bhawan|Tilhar|Tirwaganj|Tulsipur|Tundla|Ujhani|Unnao|Utraula|Varanasi|Vrindavan|Warhapur|Zaidpur|Zamania|other";
s_a[35]="Bageshwar|Dehradun|Haldwani-cum-Kathgodam|Hardwar|Kashipur|Manglaur|Mussoorie|Nagla|Nainital|Pauri|Pithoragarh|Ramnagar|Rishikesh|Roorkee|Rudrapur|Sitarganj|Tehri|other";
s_a[36]="Adra|Alipurduar|Arambagh|Asansol|Baharampur|Bally| Bankura|Baranagar|Barasat|Bardhaman|Barrackpore|Baruipur|Bolpur| Bongaon|Bulandshahr|Chandannagar M.C.|Darjiling|Diamond Harbour|Dum Dum|DurgapurMC|English Bazar| Habra|Haldia| Howrah|Hugli-Chinsurah|Jalpaiguri|Jhargram| Kalyani|Kanchrapara|Kharagpur|Kolkata|Konnagar| Krishnanagar|Madhyamgram|Mainaguri|Malda|Mathabhanga|Medinipur|Memari|Monoharpur|Murshidabad|Nabadwip|Naihati|North Dum Dum|Old Malda|Panchla|Pandua|Paschim Punropara|Purulia|Raghunathpur|Raghunathganj|Raiganj|Rajarhat-Gopalpore|Rampurhat|Ranaghat|Sainthia|Santipur|Serampore|Siliguri|Sonamukhi|South Dum Dum|Srirampore|Suri|Taki|Tamluk|Tarakeswar|Uttarpara Kotrung|other";



function print_businessstate(businessstate){
    //given the id of the <select> tag as function argument, it inserts <option> tags
    var option_str = document.getElementById(businessstate);
    option_str.length=0;
    option_str.options[0] = new Option('Select State','');
    option_str.selectedIndex = 0;
    for (var i=0; i<state_arr.length; i++) {
    option_str.options[option_str.length] = new Option(state_arr[i],state_arr[i]);
    }
}

function print_businesscity(businesscity, selectedIndex){
    var option_str = document.getElementById(businesscity);
    option_str.length=0;    // Fixed by Julian Woods
    option_str.options[0] = new Option('Select City','');
    option_str.selectedIndex = 0;
    var city_arr = s_a[selectedIndex].split("|");
    for (var i=0; i<city_arr.length; i++) {
    option_str.options[option_str.length] = new Option(city_arr[i],city_arr[i]);
    }
}
function print_userstate(userstate){
    //given the id of the <select> tag as function argument, it inserts <option> tags
    var option_str = document.getElementById(userstate);
    option_str.length=0;
    option_str.options[0] = new Option('Select State','');
    option_str.selectedIndex = 0;
    for (var i=0; i<state_arr.length; i++) {
    option_str.options[option_str.length] = new Option(state_arr[i],state_arr[i]);
    }
}

function print_usercity(usercity, selectedIndex){
    var option_str = document.getElementById(usercity);
    option_str.length=0;    // Fixed by Julian Woods
    option_str.options[0] = new Option('Select City','');
    option_str.selectedIndex = 0;
    var city_arr = s_a[selectedIndex].split("|");
    for (var i=0; i<city_arr.length; i++) {
    option_str.options[option_str.length] = new Option(city_arr[i],city_arr[i]);
    }
}






function print_state(country){
    //given the id of the <select> tag as function argument, it inserts <option> tags
    var option_str = document.getElementById(country);
    option_str.length=0;
    option_str.options[0] = new Option('Select State','');
    option_str.selectedIndex = 0;
    for (var i=0; i<state_arr.length; i++) {
    option_str.options[option_str.length] = new Option(state_arr[i],state_arr[i]);
    }
}

function print_city(state, selectedIndex){
    var option_str = document.getElementById(state);
    option_str.length=0;    // Fixed by Julian Woods
    option_str.options[0] = new Option('Select City','');
    option_str.selectedIndex = 0;
    var city_arr = s_a[selectedIndex].split("|");
    for (var i=0; i<city_arr.length; i++) {
    option_str.options[option_str.length] = new Option(city_arr[i],city_arr[i]);
    }
}

function print_orgstate(orgState){
    //given the id of the <select> tag as function argument, it inserts <option> tags
    var option_str = document.getElementById(orgState);
    option_str.length=0;
    option_str.options[0] = new Option('Select State','');
    option_str.selectedIndex = 0;
    for (var i=0; i<state_arr.length; i++) {
    option_str.options[option_str.length] = new Option(state_arr[i],state_arr[i]);
    }
}

function print_orgcity(orgCity, selectedIndex){
    var option_str = document.getElementById(orgCity);
    option_str.length=0;    // Fixed by Julian Woods
    option_str.options[0] = new Option('Select City','');
    option_str.selectedIndex = 0;
    var city_arr = s_a[selectedIndex].split("|");
    for (var i=0; i<city_arr.length; i++) {
    option_str.options[option_str.length] = new Option(city_arr[i],city_arr[i]);
    }
}