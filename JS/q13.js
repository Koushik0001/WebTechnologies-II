//#####################################################################################################################################
//                                      **    Functions directly called from the main form   **
function add() {
    displayPopup("add");
}

function show() {
    getAllItems();
}

function update() {
    displayPopup("update");
}

function remove() {
    displayPopup("delete");
}

//#####################################################################################################################################





//#####################################################################################################################################
//                                      **    Functions called from the popup form   **

function okAdd() {
    const errorLabel = document.getElementById("info_addPopup");
    if (document.querySelector('#addPopup-component-selection-dropdown .button_dropdown').value == 'Choose Component Type' || document.querySelector('#add-popup-form #manufacturer').value == '') {
        errorLabel.textContent = 'Both Fields are required to add the components...';
        if (document.getElementById("info_addPopup").classList.contains('success'))
            document.getElementById("info_addPopup").classList.remove('success');
        errorLabel.classList.add('error');
    }
    else {
        errorLabel.textContent = '';
        component = {
            type: comboBoxes['addPopup-component-selection-dropdown'][3].value,
            manufacturer: document.querySelector('#add-popup-form #manufacturer').value,
            price: document.querySelector('#add-popup-form #price').value
        };
        comboBoxes['addPopup-component-selection-dropdown'][3].value = 'Choose Component Type';
        document.querySelector('#add-popup-form #manufacturer').value = '';
        document.querySelector('#add-popup-form #price').value = '';
        insertComponent(component);
    }
}

function okDelete() {
    const errorLabel = document.getElementById("info_deletePopup");
    if (document.querySelector('#deletePopup-component-selection-dropdown .button_dropdown').value == 'Choose Component Type' || document.querySelector('#delete-popup-form #manufacturer').value == '') {
        errorLabel.textContent = 'Both Fields are required to delete the components...';
        if (document.getElementById("info_deletePopup").classList.contains('success'))
            document.getElementById("info_deletePopup").classList.remove('success');
        errorLabel.classList.add('error');
    }
    else {
        errorLabel.textContent = '';
        key = [comboBoxes['deletePopup-component-selection-dropdown'][3].value, document.querySelector('#delete-popup-form #manufacturer').value
        ];
        comboBoxes['deletePopup-component-selection-dropdown'][3].value = 'Choose Component Type';
        document.querySelector('#delete-popup-form #manufacturer').value = '';
        deleteComponent(key);
    }
}

function okUpdate() {
    const errorLabel = document.getElementById("info_updatePopup");
    if (document.querySelector('#updatePopup-component-selection-dropdown .button_dropdown').value == 'Choose Component Type' || document.querySelector('#update-popup-form #manufacturer').value == '') {
        errorLabel.textContent = 'Both Fields are required to add the components...';
        if (document.getElementById("info_updatePopup").classList.contains('success'))
            document.getElementById("info_updatePopup").classList.remove('success');
        errorLabel.classList.add('error');
    }
    else {
        errorLabel.textContent = '';
        component = {
            type: comboBoxes['updatePopup-component-selection-dropdown'][3].value,
            manufacturer: document.querySelector('#update-popup-form #manufacturer').value,
            price: document.querySelector('#update-popup-form #price').value
        };
        comboBoxes['updatePopup-component-selection-dropdown'][3].value = 'Choose Component Type';
        document.querySelector('#update-popup-form #manufacturer').value = '';
        document.querySelector('#update-popup-form #price').value = '';
        updateComponent(component);
    }
}

function cancelAdd() {
    hidePopup("add");
}
function cancelUpdate() {
    hidePopup("update");
}

function cancelDelete() {
    hidePopup("delete");
}

//#####################################################################################################################################





//#####################################################################################################################################
//                                      **    Functions accessing the database  **
// create an instance of a db object for us to store the IDB data in
var db;

function deleteComponent(key) {
    // open a database transaction and delete the task, finding it by the name we retrieved above
    let transaction = db.transaction(['ComponentsList'], 'readwrite');
    var objectStore = transaction.objectStore('ComponentsList');
    var request = objectStore.get(key);
    request.onsuccess = function () {
        if (request.result === undefined) {
            // no record with that key
            if (document.getElementById("info_deletePopup").classList.contains('success'))
                document.getElementById("info_deletePopup").classList.remove('success');
            document.getElementById("info_deletePopup").textContent = 'Item was not found...';
            document.getElementById("info_deletePopup").classList.add('error');
        } else {
            deleteRequest = objectStore.delete(key);
            deleteRequest.onsuccess = function () {
                if (document.getElementById("info_deletePopup").classList.contains('error'))
                    document.getElementById("info_deletePopup").classList.remove('error');
                document.getElementById("info_deletePopup").textContent = 'One component deleted successfully...';
                document.getElementById("info_deletePopup").classList.add('success');
            }
        }

        // report that the data item has been deleted
        transaction.oncomplete = function () {
            console.log("Transaction completed...");
        };
    }
}

function insertComponent(component) {
    var transaction = db.transaction(['ComponentsList'], 'readwrite');
    var objectStore = transaction.objectStore('ComponentsList');
    var key = [component['type'], component['manufacturer']];
    var request = objectStore.get(key);
    request.onsuccess = function () {

        if (request.result === undefined) {
            var addRequest = objectStore.add(component);
            addRequest.onsuccess = function () {
                if (document.getElementById("info_addPopup").classList.contains('error'))
                    document.getElementById("info_addPopup").classList.remove('error');
                document.getElementById("info_addPopup").textContent = 'One component added successfully...';
                document.getElementById("info_addPopup").classList.add('success');
            }
        }
        else {
            console.log("Item already exists...");
            // no record with that key
            if (document.getElementById("info_addPopup").classList.contains('success'))
                document.getElementById("info_addPopup").classList.remove('success');
            document.getElementById("info_addPopup").textContent = 'Item already exists in the database...';
            document.getElementById("info_addPopup").classList.add('error');
        }
    }

    transaction.oncomplete = function () {
        console.log("Transaction complete...");
    };
}

function updateComponent(component) {
    var transaction = db.transaction(['ComponentsList'], 'readwrite');
    var objectStore = transaction.objectStore('ComponentsList');
    var key = [component['type'], component['manufacturer']];
    var request = objectStore.get(key);
    request.onsuccess = function () {
        if (request.result === undefined) {
            // no record with that key
            if (document.getElementById("info_updatePopup").classList.contains('success'))
                document.getElementById("info_updatePopup").classList.remove('success');
            document.getElementById("info_updatePopup").textContent = 'Item was not found...';
            document.getElementById("info_updatePopup").classList.add('error');
        } else {
            updateRequest = objectStore.put(component);
            updateRequest.onsuccess = function () {
                if (document.getElementById("info_updatePopup").classList.contains('error'))
                    document.getElementById("info_updatePopup").classList.remove('error');
                document.getElementById("info_updatePopup").textContent = 'One component updated successfully...';
                document.getElementById("info_updatePopup").classList.add('success');
            }
        }
    }

    transaction.oncomplete = function () {
        console.log("Transaction complete...");
    };
}

function getAllItems() {
    var trans = db.transaction(['ComponentsList'], 'readonly');
    trans.onerror = function (error) {
        console.log(error);
    };

    var store = trans.objectStore('ComponentsList');
    var cursorRequest = store.openCursor();
    var items = [];

    cursorRequest.onerror = function (error) {
        console.log(error);
    };

    cursorRequest.onsuccess = function (evt) {
        var cursor = evt.target.result;
        if (cursor) {
            items.push(cursor.value);
            cursor.continue();
        }
        if(items.length == 0)
        {
            //logic can be added here for handling the show button click when no data is actually present in the dayabase
            return;
        }

        const items_description = document.querySelector("#items-description");
        while (items_description.firstChild)
            items_description.removeChild(items_description.firstChild);
        items_description.classList.add("active");


        const table = document.createElement("table");
        const thead = document.createElement("thead");
        const tbody = document.createElement("tbody");
        const headRow = document.createElement("tr");

        table.setAttribute('class', 'items-table');
        
        for (key of Object.keys(items[0])) {
            var th = document.createElement("th");
            th.setAttribute('scope', 'col');
            th.innerText = `${key}`;
            headRow.appendChild(th);
        }
        thead.appendChild(headRow);

        for (item of items) {
            var tr = document.createElement("tr");
            for (key of Object.keys(item)) {
                var td = document.createElement("td");
                td.innerText = item[key];
                tr.appendChild(td);
            }
            tbody.appendChild(tr);
        }

        table.appendChild(thead);
        table.appendChild(tbody);
        items_description.appendChild(table);
    };

}

//#####################################################################################################################################





//#####################################################################################################################################
//                                    ** Utility funcitons for handling the UI **
/*This is an object with key value paires where key is the id of the li element that hlods the combobox's various components
comboBoxes = 
{
    id_of_li : [active/inctive, dropdownPopupReference, arrowIconReference, dropdownButtonReference, optionsList]
}
*/
var comboBoxes = {};
var arrowRotationAmounts = {};//This is an object with key value paires where key is the id of the li element that hlods the combobox and value is the rotation of the down arrow image

function displayPopup(popupName) {
    document.getElementById(`info_${popupName}Popup`).textContent = '';
    popup = document.getElementById(`${popupName}-popup`);
    main_form = document.getElementById("main-form");
    popup.classList.add("active");
    main_form.classList.add("blurr-effect");
}

function hidePopup(popupName) {
    popup = document.getElementById(`${popupName}-popup`);
    main_form = document.getElementById("main-form");
    popup.classList.remove("active");
    main_form.classList.remove("blurr-effect");
}

function dropdown_handler(dropdown_id) {
    if (dropdown_id in arrowRotationAmounts && dropdown_id in comboBoxes) {
        if (arrowRotationAmounts[dropdown_id] == 0)
            arrowRotationAmounts[dropdown_id] = 180;
        else
            arrowRotationAmounts[dropdown_id] = 0;
    }
    else {
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
}
//#####################################################################################################################################
//                                          ** Funcitons for validating input **


function validateManufacturer(popupName) {
    const inputName = document.getElementById("manufacturer").value;
    const inputField = document.getElementById("manufacturer");
    const errorLabel = document.getElementById(`info_${popupName}Popup`);

    var rexp = /^[a-zA-Z0-9_]+$/
    if (rexp.test(inputName) && inputName.length <= 20 && inputName.length > 0) {
        inputField.className = "right_input";
        errorLabel.textContent = '';
    }
    else {
        if (errorLabel.classList.contains('success'))
            errorLabel.classList.remove('success');
        errorLabel.classList.add('error');

        inputField.className = "wrong_input";

        if (inputName.length == 0) {
            errorLabel.textContent = "Manufacturer must not be empty.";
        }
        else if (!rexp.test(inputName)) {
            errorLabel.textContent = "Only alpha-numeric characters and underscores are allowed.";
        }
        else if (inputName.length > 20) {
            errorLabel.textContent = "Number of characters must be less than or equal to 10.";
        }
    }
}

function validatePrice(popupName) {
    const input = document.getElementById("price").value;
    const inputField = document.getElementById("price");
    const errorLabel = document.getElementById(`info_${popupName}Popup`);

    var rexp = /^[0-9]+$/
    if (rexp.test(input) && input.length <= 20 && input.length > 0) {
        inputField.className = "right_input";
        errorLabel.textContent = '';
    }
    else {
        if (errorLabel.classList.contains('success'))
            errorLabel.classList.remove('success');
        errorLabel.classList.add('error');

        inputField.className = "wrong_input";

        if (input.length == 0) {
            errorLabel.textContent = "Price must not be empty.";
        }
        else if (!rexp.test(inputName)) {
            errorLabel.textContent = "Only numeric characters are allowed.";
        }
    }
}

//#####################################################################################################################################




window.onload = function () {
    // In the following line, you should include the prefixes of implementations you want to test.
    window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    // DON'T use "var indexedDB = ..." if you're not in a function.
    // Moreover, you may need references to some window.IDB* objects:
    window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;
    window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;
    // (Mozilla has never prefixed these objects, so we don't need window.mozIDB*)

    var DBOpenRequest = window.indexedDB.open('KMComponentsDatabase106', 1);

    DBOpenRequest.onsuccess = function (event) {
        db = DBOpenRequest.result;
        // populateData();
    };

    DBOpenRequest.onupgradeneeded = function (event) {
        var db = event.target.result;

        db.onerror = function (event) {
            note.innerHTML += '<li>Error loading database.</li>';
        };

        var objectStore = db.createObjectStore('ComponentsList', { keyPath: ['type', 'manufacturer'] });
        objectStore.createIndex('type', 'type', { unique: false });
        objectStore.createIndex('manufacturer', 'manufacturer', { unique: false });
    };
};



