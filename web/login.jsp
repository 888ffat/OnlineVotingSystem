<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Login - Online Student Election System</title>

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

/* ===== Particle canvas ===== */
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
    width:100%;
    height:100%;
    position:relative;
    z-index:1;
}

/* ===== Left info section ===== */
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
    font-size:42px;
    margin-bottom:15px;
}

.info p{
    font-size:16px;
    line-height:1.6;
    max-width:420px;
}

.features{
    margin-top:25px;
}

.features li{
    margin-bottom:10px;
}

/* ===== Login Section ===== */
.login-section{
    width:420px;
    background:rgba(255,255,255,0.96);
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:-6px 0 30px rgba(0,0,0,0.25);

    /* slide animation */
    animation: slideIn 0.8s ease;
}

@keyframes slideIn{
    from{transform:translateX(60px); opacity:0;}
    to{transform:translateX(0); opacity:1;}
}

.card{
    width:85%;
}

/* ===== Title ===== */
.card h2{
    text-align:center;
    margin-bottom:25px;
    color:#1f3c88;
}

/* ===== Inputs ===== */
label{
    font-size:13px;
    font-weight:600;
    margin-top:14px;
    display:block;
}

input{
    width:100%;
    padding:10px 12px;
    margin-top:6px;
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

/* ===== Button ===== */
button{
    width:100%;
    margin-top:22px;
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

/* loading animation */
button.loading{
    pointer-events:none;
    opacity:0.8;
}

/* ===== Error ===== */
.error{
    margin-top:12px;
    color:#d9534f;
    text-align:center;
    font-size:13px;
}

/* ===== Links ===== */
.footer{
    text-align:center;
    margin-top:18px;
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
    .info{ display:none; }
    .login-section{ width:100%; }
}
</style>
</head>

<body>

<!-- ===== Floating particles canvas ===== -->
<canvas id="particles"></canvas>

<div class="wrapper">

    <!-- ===== Left Panel ===== -->
    <div class="info">
        <h1>Student Election Portal</h1>
        <p>
            Secure, fast and transparent online voting system.
            Cast your vote anytime, anywhere.
        </p>

        <ul class="features">
            <li> View ongoing elections</li>
            <li> Vote securely once</li>
            <li> Live results & statistics</li>
            <li> Fully online system</li>
        </ul>
    </div>

    <!-- ===== Login Section ===== -->
    <div class="login-section">
        <div class="card">

            <h2>Login Account</h2>

            <form method="post" action="LoginServlet" onsubmit="loading(this)">
                <label>Matric No</label>
                <input type="text" name="matric" required>

                <label>Password</label>
                <input type="password" name="password" required>

                <button id="loginBtn">Login</button>

                <% if (request.getParameter("error") != null) { %>
                    <div class="error">Invalid matric number or password</div>
                <% } %>
            </form>

            <div class="footer">
                Don't have an account?
                <a href="register.jsp">Register here</a>
            </div>

        </div>
    </div>

</div>


<!-- ================= PARTICLE JS ================= -->
<script>
const canvas = document.getElementById("particles");
const ctx = canvas.getContext("2d");

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

let particles = [];

for(let i=0;i<60;i++){
    particles.push({
        x:Math.random()*canvas.width,
        y:Math.random()*canvas.height,
        r:Math.random()*2+1,
        dx:(Math.random()-0.5)*0.5,
        dy:(Math.random()-0.5)*0.5
    });
}

function draw(){
    ctx.clearRect(0,0,canvas.width,canvas.height);

    ctx.fillStyle="rgba(255,255,255,0.6)";

    particles.forEach(p=>{
        ctx.beginPath();
        ctx.arc(p.x,p.y,p.r,0,Math.PI*2);
        ctx.fill();

        p.x+=p.dx;
        p.y+=p.dy;

        if(p.x<0||p.x>canvas.width) p.dx*=-1;
        if(p.y<0||p.y>canvas.height) p.dy*=-1;
    });

    requestAnimationFrame(draw);
}

draw();

/* ===== login loading animation ===== */
function loading(form){
    const btn=document.getElementById("loginBtn");
    btn.innerText="Logging in...";
    btn.classList.add("loading");
}
</script>

</body>
</html>
