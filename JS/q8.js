const subjects = {
    '1st':{'1st' : ["one", "two", "three", "four", "five"], '2nd' : ["six", "seven", "eight", "nine", "ten"]},
    '2nd':{'1st' : ["eleven", "twelve", "thirteen", "fourteen"], '2nd' : ["fifteen", "sixteen", "seventeen","eightee"]},
    '3rd':{'1st' : ["nineteen","twenty", "twenty-one"], '2nd' : ["twenty-two", "twenty-three"]},
    '4th':{'1st' : ["twenty-four, twenty-five"], '2nd' : ["twenty-six", "twenty-seven"]}
}
function showSubjects(){
    const subject_description = document.querySelector("#subject-description");
    while (subject_description.firstChild)
        subject_description.removeChild(subject_description.firstChild);
    subject_description.classList.remove("active");

    const year = document.querySelector("#year-selection-dropdown .button_dropdown").value;
    const semester = document.querySelector("#semester-selection-dropdown .button_dropdown").value;
    if(year=="Choose Year" || semester=="Choose Year")
    {
        const error = document.createElement("p");
        error.setAttribute("class","error");
        error.innerHTML = "You must choose both Year and Semester to see the subjects...";
        subject_description.appendChild(error);
        return;
    }

    subject_description.classList.add("active");

    const heading = document.createElement("p");
    const ul = document.createElement("ul");
    
    heading.setAttribute("class", "heading");
    ul.setAttribute("class", "subject-list");
    heading.appendChild(document.createTextNode(`Subjects for ${year} year ${semester} semester : `));
    var i = 1;
    for(subject of subjects[year][semester])
    {
        const subject_wrapper = document.createElement("li");
        const bullet = document.createElement("div");
        const subject_name = document.createElement("div");

        subject_wrapper.setAttribute("class","subject-wrapper");
        bullet.setAttribute("class", "bullet");
        subject_name.setAttribute("class","subject");
        
        bullet.innerHTML = i;
        subject_name.innerText = subject;

        subject_wrapper.appendChild(bullet);
        subject_wrapper.appendChild(subject_name);
        ul.appendChild(subject_wrapper)

        i++;
    }
    subject_description.appendChild(heading);
    subject_description.appendChild(ul);
}
//This is an object with key value paires where key is the id of the li element that hlods the combobox and value is the rotation of the down arrow image
var arrowRotationAmounts = {};
/*This is an object with key value paires where key is the id of the li element that hlods the combobox's various components
comboBoxes = 
{
    id_of_li : [active/inctive, dropdownPopupReference, arrowIconReference, dropdownButtonReference, optionsList]
}
*/
var comboBoxes = {};


function dropdown_handler(dropdown_id) {
    if (dropdown_id in arrowRotationAmounts && dropdown_id in comboBoxes)
    {
        if (arrowRotationAmounts[dropdown_id] == 0)
            arrowRotationAmounts[dropdown_id] = 180;
        else
            arrowRotationAmounts[dropdown_id] = 0;
    }
    else
    {
        comboBoxes[dropdown_id] = [false, document.querySelector(`#${dropdown_id} .dropdown`), document.querySelector(`#${dropdown_id} .icon-arrow`), document.querySelector(`#${dropdown_id} .button_dropdown`), document.querySelectorAll(`#${dropdown_id} .dropdown-menu .option`)];
        arrowRotationAmounts[dropdown_id] = 180;
        
        //adding eventlisteners to the combobox options
        comboBoxes[dropdown_id][4].forEach(o => {
            o.addEventListener("click", () => {
                comboBoxes[dropdown_id][3].value = o.querySelector(`#${dropdown_id} .dropdown-menu .option label`).innerHTML;
                dropdown_handler(dropdown_id);
            });
        });
    }               
    comboBoxes[dropdown_id][2].style.transform = `rotate(${arrowRotationAmounts[dropdown_id]}deg)`;

    
    if (!comboBoxes[dropdown_id][1].classList.contains("active"))
    {
        for (const key in comboBoxes) 
        {
            if(comboBoxes[key][0])
            {
                if (arrowRotationAmounts[key] == 0)
                    arrowRotationAmounts[key] = 180;
                else
                    arrowRotationAmounts[key] = 0;

                comboBoxes[key][2].style.transform = `rotate(${arrowRotationAmounts[key]}deg)`;
                for(i = 1; i<4;i++)
                    comboBoxes[key][i].classList.remove("active");
                comboBoxes[key][0] = false;
            }
        }
        for(i = 1; i<4;i++)
            comboBoxes[dropdown_id][i].classList.add("active");
        comboBoxes[dropdown_id][0] = true;

    }
    else
    {
        for(i = 1; i<4;i++)
            comboBoxes[dropdown_id][i].classList.remove("active");
        comboBoxes[dropdown_id][0] = false;
    }
}