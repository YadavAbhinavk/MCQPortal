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