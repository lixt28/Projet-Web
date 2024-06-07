const urlParams = new URLSearchParams(window.location.search);
        const rejoindre = urlParams.get('rejoindre');
        if (rejoindre === 'true') {
            document.getElementById('role').style.display = 'none';
            document.getElementById('titre1').style.display = 'none';
            document.getElementById('titre2').style.display = 'block';
            document.getElementById('code_partie').style.display = 'block';
        }else{
            document.getElementById('titre2').style.display = 'none';
        }