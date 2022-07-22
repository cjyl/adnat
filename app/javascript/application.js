// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"


const edit = document.querySelector("#edit-org")
const updateForm = document.querySelector(#edit_organisation_)
edit.addEventListener("click", (e) =>{
  console.log("hello")
  updateForm.classList.toggle('invisible');
})
