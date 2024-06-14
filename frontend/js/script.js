
//Fonction pour envoyer les donnees vers l'API
function handleSubMIt(event) {

    // Empêche l'envoi du formulaire
    event.preventDefault(); 

    //recuperer le parametre rataché s'il existe
    const urlParams = new URLSearchParams(window.location.search);
    const rejoindre = urlParams.get('rejoindre');

    // Récupérer les valeurs des champs du formulaire
    var IsnotcreatorOfGame = (rejoindre === "true") ? "true" : (rejoindre == '') ? "false" : "false";

    var name = document.getElementById('name').value;
    var roleSelect = document.getElementById('role');

        //Parcourir la balise select et recuperer la valeur du role selectionné , s'il existe pas , on le determine de facon aleatoire par la fonction aleatoire()
    var roleOption = roleSelect.options[roleSelect.selectedIndex].value;
    var role = roleOption === 'aleatoire' ? choisirRoleAleatoire() : roleOption;

    var part_codeInput = document.getElementById('part_code');
    var partCode = (part_codeInput.value === '') ? generatePartCode().toString() : (part_codeInput.value !== '') ? part_codeInput.value : generatePartCode().toString();

    
    console.log('JSON envoyé:', JSON.stringify({
        name,
        role,
        partCode,
        IsnotcreatorOfGame
    }));
    // Traitez les valeurs récupérées 
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
       
    }),
})
.then(response => response.json())
.then(data => {
    // Afficher la reponse apres l'envoie des donnees
    alert(JSON.stringify(JSON.parse(data).message));
    console.log(JSON.stringify(JSON.parse(data)));

    const trimmedMessage = JSON.parse(data).message.trim().toLowerCase();
    const successMessageMJ = "Good luck ! you are Game Master".toLowerCase();
    const successMessageMI = "Good luck ! you are Master of Intuitions".toLowerCase();

    if (trimmedMessage === successMessageMJ || trimmedMessage === successMessageMI) {
       
        //Recuperer les valeurs contenues dans la reponse apres insertion
        const partCode = encodeURIComponent(JSON.parse(data).partCode); 
        const role = encodeURIComponent(JSON.parse(data).role);
        console.log(JSON.parse(data).role);
        
        localStorage.setItem("playerName", name);
        localStorage.setItem("playerRole", role);

        //Redirection selon le role 
        if (role === "GM") {
            window.location.href = './game_master_view.html';
        } 
        if (role === "MI") {
            window.location.href = './master_intuition_view.html';
            console.log(localStorage.getItem("playerRole"));
        } 

            
    } else {
        window.location.href = '../index.html';
    }
})
.catch((error) => {
    console.error('Error:', error);
});
}


//Fonction pour le choix du role de facon aleatoire
function choisirRoleAleatoire() {
    var roles = ['GM', 'MI'];
    var randoMIndex = Math.floor(Math.random() * roles.length);
    return roles[randoMIndex];
}

// Fonction pour générer un code de partie aléatoire
function generatePartCode() {
   
    var caracter = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var length = 8;
    var part_code = '';
    for (var i = 0; i < length; i++) {
        part_code += caracter.charAt(Math.floor(Math.random() * caracter.length));
    }
    return part_code;
}

//Fonction pour l'affichage de certaines parties du HTML selon si on veut creer ou rejoindre une partie
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

    document.getElementById('form').addEventListener('submit', handleSubMIt);
}

window.addEventListener("load", PartManagement);
