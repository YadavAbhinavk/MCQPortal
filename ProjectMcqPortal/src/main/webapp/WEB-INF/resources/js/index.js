function toggleMenu() {
    var navLinks = document.getElementById("navLinks");
    navLinks.classList.toggle("active");
}

function onClick() {
			var resultElements = document.getElementsByClassName("result");

			for (var i = 0; i < resultElements.length; i++) {
				resultElements[i].style.display = "block";
			}
		}
		
function hideMessage() {
  var messageElement = document.getElementById("message");
  if (messageElement) {
    messageElement.style.display = "none";
  }
}
setTimeout(hideMessage, 5000); 


function validateMobileNumber(input) {
        const mobileNumber = input.value;
        const errorElement = document.getElementById("mobileNumberError");

        // Regular expression to match non-numeric characters
        const nonNumericPattern = /[^0-9]/g;

        if (nonNumericPattern.test(mobileNumber)) {
            errorElement.textContent = "Please enter only numeric characters.";
        } else {
            errorElement.textContent = ""; // Clear any previous error message
        }
    }
    
    function validatePassword(input) {
        const password = input.value;
        const errorElement = document.getElementById("passwordError");

        // Regular expressions for validation
        const uppercasePattern = /[A-Z]/;
        const lowercasePattern = /[a-z]/;
        const numericPattern = /[0-9]/;
        const specialCharacterPattern = /[^A-Za-z0-9]/;

        // Check for each condition
        const hasUppercase = uppercasePattern.test(password);
        const hasLowercase = lowercasePattern.test(password);
        const hasNumeric = numericPattern.test(password);
        const hasSpecialCharacter = !specialCharacterPattern.test(password);

        // Check length constraints
        const isWithinLengthRange = password.length >= 6 && password.length <= 15;

        // Check if all conditions are met
        if (hasUppercase && hasLowercase && hasNumeric && hasSpecialCharacter && isWithinLengthRange) {
            errorElement.textContent = ""; // Password is valid
        } else {
            errorElement.textContent = "Password must have at least one uppercase letter, one lowercase letter, one numeric digit, no special characters, and be between 6 and 15 characters long.";
        }
    }
	function validateName(input) {
            const name = input.value;
            const errorElement = document.getElementById("nameError");

            // Regular expression to match alphabetic characters and spaces
            const alphabeticWithSpacesPattern = /^[A-Za-z\s]+$/;

            if (alphabeticWithSpacesPattern.test(name)) {
                errorElement.textContent = ""; // Name is valid
            } else {
                errorElement.textContent = "Name must contain only alphabetic characters and spaces.";
            }
        }
    
function confirmDelete(tag, isAvailable) {
    if (isAvailable === "active") {
        var confirmDeactivate = confirm("The test is currently active. Are you sure you want to delete it? Please deactivate it first.");
        if (confirmDeactivate) {
            // Redirect to a deactivate endpoint or handle deactivation logic here
            window.location.href = "<%= request.getContextPath() %>/update_tests/"+tag;
        }
    } else {
        var confirmDelete = confirm("Are you sure you want to delete the whole Test?");
        if (confirmDelete) {
            window.location.href = "<%= request.getContextPath() %>/delete_test/"+tag;
        }
    }
}