<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Register - Online Student Election System</title>

<style>
*{
    box-sizing:border-box;
}

body{
    margin:0;
    font-family:"Segoe UI", Arial, sans-serif;
    height:100vh;
    overflow:hidden;
    background: linear-gradient(135deg,#1f3c88,#4a80ff);
}

/* ===== PARTICLES ===== */
#particles{
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    z-index:0;
}

/* ===== Layout ===== */
.wrapper{
    display:flex;
    height:100%;
    position:relative;
    z-index:1;
}

/* ===== Left Info Panel ===== */
.info{
    flex:1;
    color:white;
    padding:80px 70px;
    display:flex;
    flex-direction:column;
    justify-content:center;
    animation: fadeLeft 1s ease;
}

@keyframes fadeLeft{
    from{opacity:0; transform:translateX(-40px);}
    to{opacity:1; transform:translateX(0);}
}

.info h1{
    font-size:40px;
    margin-bottom:15px;
}

.info p{
    max-width:420px;
    line-height:1.6;
}

.features{
    margin-top:25px;
}

.features li{
    margin-bottom:10px;
}

/* ===== Register Section ===== */
.register-section{
    width:450px;
    background:rgba(255,255,255,0.96);
    display:flex;
    justify-content:center;
    align-items:center;
    box-shadow:-6px 0 30px rgba(0,0,0,0.25);
    animation: slideIn 0.8s ease;
}

@keyframes slideIn{
    from{transform:translateX(60px); opacity:0;}
    to{transform:translateX(0); opacity:1;}
}

.card{
    width:85%;
    max-height:92vh;
    overflow-y:auto;
    padding-right:4px;
}

.card h2{
    text-align:center;
    margin-bottom:18px;
    color:#1f3c88;
}

/* ===== Inputs ===== */
label{
    font-size:13px;
    font-weight:600;
    margin-top:12px;
    display:block;
}

input{
    width:100%;
    padding:10px 12px;
    margin-top:5px;
    border-radius:8px;
    border:1px solid #ccc;
    font-size:14px;
    transition:0.2s;
}

input:focus{
    border-color:#4a80ff;
    box-shadow:0 0 6px rgba(74,128,255,0.3);
    outline:none;
}

/* password wrapper */
.pass-wrap{
    position:relative;
}

.show-pass{
    position:absolute;
    right:10px;
    top:50%;
    transform:translateY(-50%);
    cursor:pointer;
    font-size:12px;
    color:#4a80ff;
}

/* strength */
.strength{
    font-size:12px;
    margin-top:4px;
}

/* ===== Button ===== */
button{
    width:100%;
    margin-top:18px;
    padding:11px;
    border:none;
    border-radius:8px;
    background:#1f3c88;
    color:white;
    font-weight:bold;
    cursor:pointer;
    transition:0.2s;
}

button:hover{
    background:#16306f;
}

button.loading{
    pointer-events:none;
    opacity:0.8;
}

/* ===== Error ===== */
.error{
    color:#d9534f;
    margin-top:10px;
    text-align:center;
    font-size:13px;
}

/* ===== Footer ===== */
.footer{
    text-align:center;
    margin-top:14px;
    font-size:13px;
}

.footer a{
    color:#1f3c88;
    font-weight:600;
    text-decoration:none;
}

.footer a:hover{
    text-decoration:underline;
}

/* responsive */
@media(max-width:900px){
    .info{display:none;}
    .register-section{width:100%;}
}
</style>
</head>

<body>

<canvas id="particles"></canvas>

<div class="wrapper">

    <!-- ===== Left Panel ===== -->
    <div class="info">
        <h1>Join the Election Portal</h1>
        <p>
            Create your student account to participate in campus elections
            and make your voice count.
        </p>

        <ul class="features">
            <li> Secure registration</li>
            <li> One student = one vote</li>
            <li> Instant results</li>
            <li> Fully online system</li>
        </ul>
    </div>

    <!-- ===== Register Form ===== -->
    <div class="register-section">
        <div class="card">

            <h2>Create Account</h2>

            <form method="post" action="RegisterServlet" onsubmit="loading()">

                <label>Full Name</label>
                <input type="text" name="fullname" required>

                <label>Matric Number</label>
                <input type="text" name="matric" required>

                <label>Email</label>
                <input type="email" name="email">

                <label>Password</label>
                <input type="password" id="pass" name="password" required onkeyup="checkStrength()">

                <div id="strength" class="strength"></div>

                <button id="btn">Register</button>

                <% if (request.getParameter("error") != null) { %>
                    <div class="error">Registration failed. Please try again.</div>
                <% } %>

            </form>

            <div class="footer">
                Already have an account?
                <a href="login.jsp">Login here</a>
            </div>

        </div>
    </div>

</div>


<!-- ================= PARTICLES ================= -->
<script>
const canvas=document.getElementById("particles");
const ctx=canvas.getContext("2d");
canvas.width=window.innerWidth;
canvas.height=window.innerHeight;

let p=[];
for(let i=0;i<70;i++){
    p.push({
        x:Math.random()*canvas.width,
        y:Math.random()*canvas.height,
        r:Math.random()*2+1,
        dx:(Math.random()-0.5)*0.5,
        dy:(Math.random()-0.5)*0.5
    });
}

function animate(){
    ctx.clearRect(0,0,canvas.width,canvas.height);
    ctx.fillStyle="rgba(255,255,255,0.6)";
    p.forEach(a=>{
        ctx.beginPath();
        ctx.arc(a.x,a.y,a.r,0,6.28);
        ctx.fill();
        a.x+=a.dx; a.y+=a.dy;
        if(a.x<0||a.x>canvas.width) a.dx*=-1;
        if(a.y<0||a.y>canvas.height) a.dy*=-1;
    });
    requestAnimationFrame(animate);
}
animate();

/* ===== Show password ===== */
function togglePass(){
    const p=document.getElementById("pass");
    p.type=p.type==="password"?"text":"password";
}

/* ===== Strength check ===== */
function checkStrength(){
    const val=document.getElementById("pass").value;
    const s=document.getElementById("strength");

    if(val.length<6){
        s.innerText="Weak password";
        s.style.color="red";
    }else if(val.match(/[A-Z]/)&&val.match(/[0-9]/)){
        s.innerText="Strong password";
        s.style.color="green";
    }else{
        s.innerText="Medium strength";
        s.style.color="orange";
    }
}

/* ===== Loading ===== */
function loading(){
    const b=document.getElementById("btn");
    b.innerText="Creating account...";
    b.classList.add("loading");
}
</script>

</body>
</html>
