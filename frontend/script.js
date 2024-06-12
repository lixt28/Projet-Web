function handleSubmit(event) {
    event.preventDefault(); // Empêche l'envoi du formulaire

    const urlParams = new URLSearchParams(window.location.search);
    const rejoindre = urlParams.get('rejoindre');
    // Récupérer les valeurs des champs du formulaire
    var IsnotcreatorOfGame = (rejoindre === "true") ? "true" : (rejoindre == '') ? "false" : "false";
    var name = document.getElementById('name').value;
    var roleSelect = document.getElementById('role');
    var roleOption = roleSelect.options[roleSelect.selectedIndex].value;
    var role = roleOption === 'aleatoire' ? choisirRoleAleatoire() : roleOption;

    var part_codeInput = document.getElementById('part_code');
    var partCode = (part_codeInput.value === '') ? generatePartCode().toString() : (part_codeInput.value !== '') ? part_codeInput.value : generatePartCode().toString();

    // Traitez les valeurs récupérées (par exemple, les envoyer à une API, les stocker, etc.)
console.log('JSON envoyé:', JSON.stringify({
        name,
        role,
        partCode,
        IsnotcreatorOfGame
    }));
    // Ajoutez ici le code pour insérer les données dans la base de données via votre API Java
    // Par exemple, en utilisant fetch() ou XMLHttpRequest

    // Exemple avec fetch (remplacez l'URL par celle de votre API):
   // Exemple avec fetch (remplacez l'URL par celle de votre API):
   fetch('http://127.0.0.1:8080/part', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    
    body: JSON.stringify({
        name,
        role,
        partCode,
        IsnotcreatorOfGame
        // Ajoutez ici d'autres champs si nécessaire
    }),
})
.then(response => response.json())
.then(data => {
    console.log(data);
    console.log(JSON.stringify(data))
    alert(JSON.stringify(data).message);
    if (data.message == "true") {
        setTimeout(() => {
            // Redirigez l'utilisateur vers la page jeu.html après avoir traité le formulaire
            window.location.href = 'jeu.html';
        }, 3000); // Délai de 3 secondes
    }
    
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
    var block_role = document.getElementById('role_block');
    var title1 = document.getElementById('title1');
    var title2 = document.getElementById('title2');
    var join_part = document.getElementById('part_code_block');
    var join_part_Input = document.getElementById('part_code');

    if (rejoindre === 'true') {
        block_role.style.display = 'none';
        title1.style.display = 'none';
        title2.style.display = 'block';
        join_part.style.display = 'block';
        join_part_Input.setAttribute('required', 'required');
    } else {
        title2.style.display = 'none';
        join_part_Input.removeAttribute('required');
    }

    document.getElementById('form').addEventListener('submit', handleSubmit);
}

window.addEventListener("load", PartManagement);
