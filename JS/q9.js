const indianStates = {
    AndraPradesh: ["Anantapur", "Chittoor", "East Godavari", "Guntur", "Kadapa", "Krishna", "Kurnool", "Prakasam", "Nellore", "Srikakulam", "Visakhapatnam", "Vizianagaram", "West Godavari"],

    ArunachalPradesh: ["Anjaw", "Changlang", "Dibang Valley", "East Kameng", "East Siang", "Kra Daadi", "Kurung Kumey", "Lohit", "Longding", "Lower Dibang Valley", "Lower Subansiri", "Namsai", "Papum Pare", "Siang", "Tawang", "Tirap", "Upper Siang", "Upper Subansiri", "West Kameng", "West Siang", "Itanagar"],

    Assam: ["Baksa", "Barpeta", "Biswanath", "Bongaigaon", "Cachar", "Charaideo", "Chirang", "Darrang", "Dhemaji", "Dhubri", "Dibrugarh", "Goalpara", "Golaghat", "Hailakandi", "Hojai", "Jorhat", "Kamrup Metropolitan", "Kamrup (Rural)", "Karbi Anglong", "Karimganj", "Kokrajhar", "Lakhimpur", "Majuli", "Morigaon", "Nagaon", "Nalbari", "Dima Hasao", "Sivasagar", "Sonitpur", "South Salmara Mankachar", "Tinsukia", "Udalguri", "West Karbi Anglong"],

    Bihar: ["Araria", "Arwal", "Aurangabad", "Banka", "Begusarai", "Bhagalpur", "Bhojpur", "Buxar", "Darbhanga", "East Champaran", "Gaya", "Gopalganj", "Jamui", "Jehanabad", "Kaimur", "Katihar", "Khagaria", "Kishanganj", "Lakhisarai", "Madhepura", "Madhubani", "Munger", "Muzaffarpur", "Nalanda", "Nawada", "Patna", "Purnia", "Rohtas", "Saharsa", "Samastipur", "Saran", "Sheikhpura", "Sheohar", "Sitamarhi", "Siwan", "Supaul", "Vaishali", "West Champaran"],

    Chhattisgarh: ["Balod", "Baloda Bazar", "Balrampur", "Bastar", "Bemetara", "Bijapur", "Bilaspur", "Dantewada", "Dhamtari", "Durg", "Gariaband", "Janjgir Champa", "Jashpur", "Kabirdham", "Kanker", "Kondagaon", "Korba", "Koriya", "Mahasamund", "Mungeli", "Narayanpur", "Raigarh", "Raipur", "Rajnandgaon", "Sukma", "Surajpur", "Surguja"],

    Goa: ["North Goa", "South Goa"],

    Gujarat: ["Ahmedabad", "Amreli", "Anand", "Aravalli", "Banaskantha", "Bharuch", "Bhavnagar", "Botad", "Chhota Udaipur", "Dahod", "Dang", "Devbhoomi Dwarka", "Gandhinagar", "Gir Somnath", "Jamnagar", "Junagadh", "Kheda", "Kutch", "Mahisagar", "Mehsana", "Morbi", "Narmada", "Navsari", "Panchmahal", "Patan", "Porbandar", "Rajkot", "Sabarkantha", "Surat", "Surendranagar", "Tapi", "Vadodara", "Valsad"],

    Haryana: ["Ambala", "Bhiwani", "Charkhi Dadri", "Faridabad", "Fatehabad", "Gurugram", "Hisar", "Jhajjar", "Jind", "Kaithal", "Karnal", "Kurukshetra", "Mahendragarh", "Mewat", "Palwal", "Panchkula", "Panipat", "Rewari", "Rohtak", "Sirsa", "Sonipat", "Yamunanagar"],

    HimachalPradesh: ["Bilaspur", "Chamba", "Hamirpur", "Kangra", "Kinnaur", "Kullu", "Lahaul Spiti", "Mandi", "Shimla", "Sirmaur", "Solan", "Una"],

    JammuKashmir: ["Anantnag", "Bandipora", "Baramulla", "Budgam", "Doda", "Ganderbal", "Jammu", "Kargil", "Kathua", "Kishtwar", "Kulgam", "Kupwara", "Leh", "Poonch", "Pulwama", "Rajouri", "Ramban", "Reasi", "Samba", "Shopian", "Srinagar", "Udhampur"],

    Jharkhand: ["Bokaro", "Chatra", "Deoghar", "Dhanbad", "Dumka", "East Singhbhum", "Garhwa", "Giridih", "Godda", "Gumla", "Hazaribagh", "Jamtara", "Khunti", "Koderma", "Latehar", "Lohardaga", "Pakur", "Palamu", "Ramgarh", "Ranchi", "Sahebganj", "Seraikela Kharsawan", "Simdega", "West Singhbhum"],

    Karnataka: ["Bagalkot", "Bangalore Rural", "Bangalore Urban", "Belgaum", "Bellary", "Bidar", "Vijayapura", "Chamarajanagar", "Chikkaballapur", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharwad", "Gadag", "Gulbarga", "Hassan", "Haveri", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysore", "Raichur", "Ramanagara", "Shimoga", "Tumkur", "Udupi", "Uttara Kannada", "Yadgir"],

    Kerala: ["Alappuzha", "Ernakulam", "Idukki", "Kannur", "Kasaragod", "Kollam", "Kottayam", "Kozhikode", "Malappuram", "Palakkad", "Pathanamthitta", "Thiruvananthapuram", "Thrissur", "Wayanad"],

    MadhyaPradesh: ["Agar Malwa", "Alirajpur", "Anuppur", "Ashoknagar", "Balaghat", "Barwani", "Betul", "Bhind", "Bhopal", "Burhanpur", "Chhatarpur", "Chhindwara", "Damoh", "Datia", "Dewas", "Dhar", "Dindori", "Guna", "Gwalior", "Harda", "Hoshangabad", "Indore", "Jabalpur", "Jhabua", "Katni", "Khandwa", "Khargone", "Mandla", "Mandsaur", "Morena", "Narsinghpur", "Neemuch", "Panna", "Raisen", "Rajgarh", "Ratlam", "Rewa", "Sagar", "Satna", "Sehore", "Seoni", "Shahdol", "Shajapur", "Sheopur", "Shivpuri", "Sidhi", "Singrauli", "Tikamgarh", "Ujjain", "Umaria", "Vidisha"],

    Maharashtra: ["Ahmednagar", "Akola", "Amravati", "Aurangabad", "Beed", "Bhandara", "Buldhana", "Chandrapur", "Dhule", "Gadchiroli", "Gondia", "Hingoli", "Jalgaon", "Jalna", "Kolhapur", "Latur", "Mumbai City", "Mumbai Suburban", "Nagpur", "Nanded", "Nandurbar", "Nashik", "Osmanabad", "Palghar", "Parbhani", "Pune", "Raigad", "Ratnagiri", "Sangli", "Satara", "Sindhudurg", "Solapur", "Thane", "Wardha", "Washim", "Yavatmal"],

    Manipur: ["Bishnupur", "Chandel", "Churachandpur", "Imphal East", "Imphal West", "Jiribam", "Kakching", "Kamjong", "Kangpokpi", "Noney", "Pherzawl", "Senapati", "Tamenglong", "Tengnoupal", "Thoubal", "Ukhrul"],

    Meghalaya: ["East Garo Hills", "East Jaintia Hills", "East Khasi Hills", "North Garo Hills", "Ri Bhoi", "South Garo Hills", "South West Garo Hills", "South West Khasi Hills", "West Garo Hills", "West Jaintia Hills", "West Khasi Hills"],

    Mizoram: ["Aizawl", "Champhai", "Kolasib", "Lawngtlai", "Lunglei", "Mamit", "Saiha", "Serchhip", "Aizawl", "Champhai", "Kolasib", "Lawngtlai", "Lunglei", "Mamit", "Saiha", "Serchhip"],

    Nagaland: ["Dimapur", "Kiphire", "Kohima", "Longleng", "Mokokchung", "Mon", "Peren", "Phek", "Tuensang", "Wokha", "Zunheboto"],

    Odisha: ["Angul", "Balangir", "Balasore", "Bargarh", "Bhadrak", "Boudh", "Cuttack", "Debagarh", "Dhenkanal", "Gajapati", "Ganjam", "Jagatsinghpur", "Jajpur", "Jharsuguda", "Kalahandi", "Kandhamal", "Kendrapara", "Kendujhar", "Khordha", "Koraput", "Malkangiri", "Mayurbhanj", "Nabarangpur", "Nayagarh", "Nuapada", "Puri", "Rayagada", "Sambalpur", "Subarnapur", "Sundergarh"],

    Punjab: ["Amritsar", "Barnala", "Bathinda", "Faridkot", "Fatehgarh Sahib", "Fazilka", "Firozpur", "Gurdaspur", "Hoshiarpur", "Jalandhar", "Kapurthala", "Ludhiana", "Mansa", "Moga", "Mohali", "Muktsar", "Pathankot", "Patiala", "Rupnagar", "Sangrur", "Shaheed Bhagat Singh Nagar", "Tarn Taran"],

    Rajasthan: ["Ajmer", "Alwar", "Banswara", "Baran", "Barmer", "Bharatpur", "Bhilwara", "Bikaner", "Bundi", "Chittorgarh", "Churu", "Dausa", "Dholpur", "Dungarpur", "Ganganagar", "Hanumangarh", "Jaipur", "Jaisalmer", "Jalore", "Jhalawar", "Jhunjhunu", "Jodhpur", "Karauli", "Kota", "Nagaur", "Pali", "Pratapgarh", "Rajsamand", "Sawai Madhopur", "Sikar", "Sirohi", "Tonk", "Udaipur"],

    Sikkim: ["East Sikkim", "North Sikkim", "South Sikkim", "West Sikkim"],

    TamilNadu: ["Ariyalur", "Chennai", "Coimbatore", "Cuddalore", "Dharmapuri", "Dindigul", "Erode", "Kanchipuram", "Kanyakumari", "Karur", "Krishnagiri", "Madurai", "Nagapattinam", "Namakkal", "Nilgiris", "Perambalur", "Pudukkottai", "Ramanathapuram", "Salem", "Sivaganga", "Thanjavur", "Theni", "Thoothukudi", "Tiruchirappalli", "Tirunelveli", "Tiruppur", "Tiruvallur", "Tiruvannamalai", "Tiruvarur", "Vellore", "Viluppuram", "Virudhunagar"],

    Telangana: ["Adilabad", "Bhadradri Kothagudem", "Hyderabad", "Jagtial", "Jangaon", "Jayashankar", "Jogulamba", "Kamareddy", "Karimnagar", "Khammam", "Komaram Bheem", "Mahabubabad", "Mahbubnagar", "Mancherial", "Medak", "Medchal", "Nagarkurnool", "Nalgonda", "Nirmal", "Nizamabad", "Peddapalli", "Rajanna Sircilla", "Ranga Reddy", "Sangareddy", "Siddipet", "Suryapet", "Vikarabad", "Wanaparthy", "Warangal Rural", "Warangal Urban", "Yadadri Bhuvanagiri"],

    Tripura: ["Dhalai", "Gomati", "Khowai", "North Tripura", "Sepahijala", "South Tripura", "Unakoti", "West Tripura"],

    UttarPradesh: ["Agra", "Aligarh", "Allahabad", "Ambedkar Nagar", "Amethi", "Amroha", "Auraiya", "Azamgarh", "Baghpat", "Bahraich", "Ballia", "Balrampur", "Banda", "Barabanki", "Bareilly", "Basti", "Bhadohi", "Bijnor", "Budaun", "Bulandshahr", "Chandauli", "Chitrakoot", "Deoria", "Etah", "Etawah", "Faizabad", "Farrukhabad", "Fatehpur", "Firozabad", "Gautam Buddha Nagar", "Ghaziabad", "Ghazipur", "Gonda", "Gorakhpur", "Hamirpur", "Hapur", "Hardoi", "Hathras", "Jalaun", "Jaunpur", "Jhansi", "Kannauj", "Kanpur Dehat", "Kanpur Nagar", "Kasganj", "Kaushambi", "Kheri", "Kushinagar", "Lalitpur", "Lucknow", "Maharajganj", "Mahoba", "Mainpuri", "Mathura", "Mau", "Meerut", "Mirzapur", "Moradabad", "Muzaffarnagar", "Pilibhit", "Pratapgarh", "Raebareli", "Rampur", "Saharanpur", "Sambhal", "Sant Kabir Nagar", "Shahjahanpur", "Shamli", "Shravasti", "Siddharthnagar", "Sitapur", "Sonbhadra", "Sultanpur", "Unnao", "Varanasi"],

    Uttarakhand: ["Almora", "Bageshwar", "Chamoli", "Champawat", "Dehradun", "Haridwar", "Nainital", "Pauri", "Pithoragarh", "Rudraprayag", "Tehri", "Udham Singh Nagar", "Uttarkashi"],

    WestBengal: ["Alipurduar", "Bankura", "Birbhum", "Cooch Behar", "Dakshin Dinajpur", "Darjeeling", "Hooghly", "Howrah", "Jalpaiguri", "Jhargram", "Kalimpong", "Kolkata", "Malda", "Murshidabad", "Nadia", "North 24 Parganas", "Paschim Medinipur", "Bardhaman", "Purba Medinipur", "Purulia", "South 24 Parganas", "Uttar Dinajpur"],

    AndamanNicobar: ["Nicobar", "North Middle Andaman", "South Andaman"],

    Chandigarh: ["Chandigarh"],

    DadraHaveli: ["Dadra Nagar Haveli"],

    DamanDiu: ["Daman", "Diu"],

    Delhi: ["Central Delhi", "East Delhi", "New Delhi", "North Delhi", "North East Delhi", "North West Delhi", "Shahdara", "South Delhi", "South East Delhi", "South West Delhi", "West Delhi"],

    Lakshadweep: ["Lakshadweep"],

    Puducherry: ["Karaikal", "Mahe", "Puducherry", "Yanam"]
};

//This is an object with key value paires where key is the id of the li element that hlods the combobox and value is the rotation of the down arrow image
var arrowRotationAmounts = {};
/*This is an object with key value paires where key is the id of the li element that hlods the combobox's various components
comboBoxes = 
{
    id_of_li : [active/inctive, dropdownPopupReference, arrowIconReference, dropdownButtonReference]
}
*/
var comboBoxes = {};


document.addEventListener("DOMContentLoaded", function () {
    const states = Object.keys(indianStates);
    fill_up_dropdown("state-selection-dropdown", states);
    document.querySelectorAll(`#state-selection-dropdown .dropdown-menu .option`).forEach((option) => {
        option.addEventListener("click", () => {
            document.querySelector(`#state-selection-dropdown .button_dropdown`).value = option.querySelector(`#state-selection-dropdown .dropdown-menu .option label`).innerHTML;
            dropdown_handler("state-selection-dropdown");
            document.querySelector(`#district-selection-dropdown .button_dropdown`).value = "Choose District";
            fill_up_dropdown("district-selection-dropdown", indianStates[document.querySelector(`#state-selection-dropdown .button_dropdown`).value.replace(/ /g, "")]);
            document.querySelectorAll(`#district-selection-dropdown .dropdown-menu .option`).forEach((option) => {
                option.addEventListener("click", () => {
                    document.querySelector(`#district-selection-dropdown .button_dropdown`).value = option.querySelector(`#district-selection-dropdown .dropdown-menu .option label`).innerHTML;
                    dropdown_handler("district-selection-dropdown");
                })
            })
        })
    })
});

function showInfo() {
    const district_description = document.querySelector("#district-description");
    while (district_description.firstChild)
        district_description.removeChild(district_description.firstChild);
    district_description.classList.remove("active");

    const state = document.querySelector("#state-selection-dropdown .button_dropdown").value;
    const district = document.querySelector("#district-selection-dropdown .button_dropdown").value;
    if (state == "Choose State" || district == "Choose District") {
        const error = document.createElement("p");
        error.setAttribute("class", "error");
        error.innerHTML = "You must choose both State and District to see the Information...";
        district_description.appendChild(error);
        return;
    }

    district_description.classList.add("active");

    const heading = document.createElement("p");
    const ul = document.createElement("ul");

    heading.setAttribute("class", "heading");
    ul.setAttribute("class", "info-list");
    heading.appendChild(document.createTextNode(`State : ${state}, District : ${district}`));
    var i = 1;
    const info_wrapper = document.createElement("li");
    const bullet = document.createElement("div");
    const info_name = document.createElement("div");

    info_wrapper.setAttribute("class", "info-wrapper");
    bullet.setAttribute("class", "bullet");
    info_name.setAttribute("class", "info");

    bullet.innerHTML = i;
    info_name.innerText = `${district} is a notable district of ${state}.`

    info_wrapper.appendChild(bullet);
    info_wrapper.appendChild(info_name);
    ul.appendChild(info_wrapper);

    district_description.appendChild(heading);
    district_description.appendChild(ul);
}

function fill_up_dropdown(combobox_id, optionsArray) {
    const dropdown_menu = document.querySelector(`#${combobox_id} .dropdown-menu`);
    while (dropdown_menu.firstChild)
        dropdown_menu.removeChild(dropdown_menu.firstChild);

    for (option of optionsArray) {
        const li = document.createElement("li");
        const input = document.createElement("input");
        const label = document.createElement("label");

        li.setAttribute("class", "option");
        input.setAttribute("type", "radio");
        input.setAttribute("class", "radio_dropdown");
        input.setAttribute("id", option);
        input.setAttribute("name", "state");
        input.setAttribute("value", option);
        label.setAttribute("for", option);

        label.innerHTML = option.replace(/([A-Z])/g, ' $1').trim();
        li.appendChild(input);
        li.appendChild(label);
        dropdown_menu.appendChild(li);
    }
}

function dropdown_handler(dropdown_id) {

    if (dropdown_id in arrowRotationAmounts && dropdown_id in comboBoxes) {
        if (arrowRotationAmounts[dropdown_id] == 0)
            arrowRotationAmounts[dropdown_id] = 180;
        else
            arrowRotationAmounts[dropdown_id] = 0;
    }
    else {
        comboBoxes[dropdown_id] = [/*active/inactive*/false, /*popup menu reference*/document.querySelector(`#${dropdown_id} .dropdown`), /*reference to the arrow icon*/document.querySelector(`#${dropdown_id} .icon-arrow`), /*reference to the drop down button*/document.querySelector(`#${dropdown_id} .button_dropdown`)];
        arrowRotationAmounts[dropdown_id] = 180;
    }
    comboBoxes[dropdown_id][2].style.transform = `rotate(${arrowRotationAmounts[dropdown_id]}deg)`;


    if (!comboBoxes[dropdown_id][1].classList.contains("active")) {
        for (const key in comboBoxes) {
            if (comboBoxes[key][0]) {
                if (arrowRotationAmounts[key] == 0)
                    arrowRotationAmounts[key] = 180;
                else
                    arrowRotationAmounts[key] = 0;

                comboBoxes[key][2].style.transform = `rotate(${arrowRotationAmounts[key]}deg)`;
                for (i = 1; i < 4; i++)
                    comboBoxes[key][i].classList.remove("active");
                comboBoxes[key][0] = false;
            }
        }
        for (i = 1; i < 4; i++)
            comboBoxes[dropdown_id][i].classList.add("active");
        comboBoxes[dropdown_id][0] = true;

    }
    else {
        for (i = 1; i < 4; i++)
            comboBoxes[dropdown_id][i].classList.remove("active");
        comboBoxes[dropdown_id][0] = false;
    }

    if (dropdown_id == "district-selection-dropdown" && document.querySelector(`#state-selection-dropdown .button_dropdown`).value == "Choose State") {
        const district_description = document.querySelector("#district-description");
        while (district_description.firstChild)
            district_description.removeChild(district_description.firstChild);
        const error = document.createElement("p");
        error.setAttribute("class", "error");
        error.innerHTML = "You must select State before selecting District..";
        district_description.appendChild(error);
    }
}