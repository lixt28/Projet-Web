function handleSubmit(event) {
    event.preventDefault(); // Empêche l'envoi du formulaire

    // Récupérer les valeurs des champs du formulaire
    var name = document.getElementById('name').value;
    var roleSelect = document.getElementById('role');
    var roleOption = roleSelect.options[roleSelect.selectedIndex].value;
    var role = roleOption === 'aleatoire' ? choisirRoleAleatoire() : roleOption;

    var part_codeInput = document.getElementById('part_code');
    var part_code = (part_codeInput.value === '') ? generatePartCode() : (part_codeInput.value !== '') ? part_codeInput.value : generatePartCode();

    // Traitez les valeurs récupérées (par exemple, les envoyer à une API, les stocker, etc.)
    console.log('name:', name);
    console.log('role:', role);
    console.log('code de la partie:', part_code);

    // Ajoutez ici le code pour insérer les données dans la base de données via votre API Java
    // Par exemple, en utilisant fetch() ou XMLHttpRequest

    // Exemple avec fetch (remplacez l'URL par celle de votre API):
   // Exemple avec fetch (remplacez l'URL par celle de votre API):
   fetch('/part', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify({
        name: name,
        role: role,
        part_code: part_code,
        // Ajoutez ici d'autres champs si nécessaire
    }),
})
.then(response => response.json())
.then(data => {
    console.log('Success:', data);
    // Redirigez l'utilisateur vers la page jeu.html après avoir traité le formulaire
    window.location.href = 'jeu.html';
})
.catch((error) => {
    console.error('Error:', error);
});
}



function choisirRoleAleatoire() {
    var roles = ['mj', 'mi'];
    var randomIndex = Math.floor(Math.random() * roles.length);
    return roles[randomIndex];
}
function generatePartCode() {
    // Générez un code de partie aléatoire, par exemple, une chaîne de caractères aléatoire
    var caracter = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var length = 8;
    var part_code = '';
    for (var i = 0; i < length; i++) {
        part_code += caracter.charAt(Math.floor(Math.random() * caracter.length));
    }
    return part_code;
}
function PartManagement() {
    const urlParams = new URLSearchParams(window.location.search);
    const rejoindre = urlParams.get('rejoindre');
    var block_role = document.getElementById('role_bloc');
    var title1 = document.getElementById('title1');
    var title2 = document.getElementById('title2');
    var join_part = document.getElementById('part_code_bloc');
    var join_part_Input = document.getElementById('part_code');

    if (rejoindre === 'true') {
        block_role.style.display = 'none';
        title1.style.display = 'none';
        title2.style.display = 'block';
        join_part.style.display = 'block';
        join_partInput.setAttribute('required', 'required');
    } else {
        title2.style.display = 'none';
        join_part_Input.removeAttribute('required');
    }

    document.getElementById('form').addEventListener('submit', handleSubmit);
}

window.addEventListener("load", PartManagement);
