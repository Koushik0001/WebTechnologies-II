function validateName()
{
    const inputName = document.getElementById("inputName").value;
    const inputField = document.getElementById("inputName");
    const errorLabel = document.getElementById("error_name");

    var rexp = /^[a-zA-Z0-9_]+$/
    if(rexp.test(inputName) && inputName.length <= 10)
    {
        errorLabel.style.display = "none";
        inputField.className = "right_input";
    }
    else
    {
        errorLabel.style.display = "block";
        inputField.className = "wrong_input";

        if(!rexp.test(inputName))
        {
            errorLabel.textContent = "Only alpha-numeric characters and underscores are allowed."
        }    
        if(inputName.length > 10)
        {
            errorLabel.textContent = "Number of characters must be less than or equal to 10.";
        }
    }
}

function validatePassword()
{
    const inputPassword = document.getElementById("inputPassword").value;
    const inputField = document.getElementById("inputPassword");
    const errorLabel = document.getElementById("error_password");

    var rexp = /(?=.*\d)(?=.*[A-Z])/

    if(rexp.test(inputPassword) && inputPassword.length <= 10 && inputPassword.length>=6)
    {
        errorLabel.style.display = "none";
        inputField.className = "right_input";
    }
    else
    {
        errorLabel.style.display = "block";
        inputField.className = "wrong_input";

        if(inputPassword.length > 10 || inputPassword.length<6)
        {
            errorLabel.textContent = "Password must be 6 to 10 characters long.";
        }
        else if(!rexp.test(inputPassword))
        {
            errorLabel.textContent = "Password must contain atleast one uppercase letter and a number."
        }    
    }
}
