<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>EgoMessenger 6767 | Liquid Glass Messenger</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Inter', system-ui, sans-serif;
            background: radial-gradient(circle at 20% 30%, #0a0f1e, #03060c);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        /* Жидкое стекло */
        .glass {
            background: rgba(20, 30, 45, 0.25);
            backdrop-filter: blur(16px) saturate(180%);
            -webkit-backdrop-filter: blur(16px) saturate(180%);
            border-radius: 32px;
            border: 1px solid rgba(0, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3), inset 0 1px 0 rgba(255, 255, 255, 0.1);
            transition: all 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
        }

        .liquid-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2;
            background: linear-gradient(125deg, #0a0f1e, #07111f, #0a1530);
            background-size: 200% 200%;
            animation: liquidShift 12s ease infinite;
        }

        @keyframes liquidShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .liquid-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: radial-gradient(circle at 60% 40%, rgba(0, 255, 200, 0.08), transparent 70%);
            pointer-events: none;
        }

        .messenger {
            display: flex;
            width: 1400px;
            max-width: 95vw;
            height: 90vh;
            overflow: hidden;
            gap: 12px;
            padding: 8px;
        }

        .sidebar {
            width: 300px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .user-card {
            padding: 20px;
            text-align: center;
        }

        .avatar-wrapper {
            position: relative;
            width: 100px;
            height: 100px;
            margin: 0 auto 12px;
            cursor: pointer;
        }

        .avatar-img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #0ff;
            box-shadow: 0 0 20px rgba(0, 255, 255, 0.3);
            transition: 0.2s;
        }

        .nickname {
            font-size: 20px;
            font-weight: bold;
            color: #0ff;
            text-shadow: 0 0 5px #0ff;
            cursor: pointer;
        }

        .user-id {
            font-size: 10px;
            color: #8af;
            background: rgba(0,0,0,0.4);
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-family: monospace;
            margin-top: 6px;
            word-break: break-all;
        }

        .status {
            font-size: 11px;
            color: #6f6;
            margin-top: 8px;
        }

        .online-list {
            flex: 1;
            overflow-y: auto;
            padding: 12px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .online-title {
            color: #0ff;
            font-size: 12px;
            margin-bottom: 8px;
        }

        .user-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px;
            border-radius: 24px;
            cursor: pointer;
            transition: 0.2s;
            background: rgba(30, 40, 55, 0.3);
            backdrop-filter: blur(4px);
        }

        .user-item:hover {
            background: rgba(0, 255, 200, 0.15);
            transform: translateX(4px);
        }

        .user-item.active {
            background: rgba(0, 255, 200, 0.25);
            border-left: 3px solid #0ff;
        }

        .user-avatar-small {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid #0ff;
        }

        .user-name {
            flex: 1;
            color: #fff;
            font-weight: 500;
        }

        .online-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #2f6;
            box-shadow: 0 0 6px #2f6;
        }

        .chat-area {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        .chat-header {
            padding: 16px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .chat-header-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #0ff;
        }

        .chat-header-name {
            flex: 1;
            font-size: 18px;
            font-weight: bold;
            color: #0ff;
        }

        .voice-call-btn {
            background: rgba(0, 255, 200, 0.15);
            border: 1px solid #0ff;
            color: #0ff;
            padding: 8px 18px;
            border-radius: 40px;
            cursor: pointer;
            transition: 0.2s;
            font-weight: bold;
        }

        .voice-call-btn.active {
            background: #0ff;
            color: #000;
            box-shadow: 0 0 15px #0ff;
        }

        .messages {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .message {
            display: flex;
            gap: 10px;
            max-width: 75%;
            animation: fadeSlide 0.2s ease;
        }

        @keyframes fadeSlide {
            from { opacity: 0; transform: translateY(12px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .message.my {
            align-self: flex-end;
            flex-direction: row-reverse;
        }

        .message-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
            flex-shrink: 0;
        }

        .message-bubble {
            background: rgba(25, 35, 55, 0.7);
            backdrop-filter: blur(8px);
            padding: 10px 16px;
            border-radius: 22px;
            color: #fff;
            word-break: break-word;
            border: 1px solid rgba(0, 255, 200, 0.2);
        }

        .message.my .message-bubble {
            background: rgba(0, 255, 200, 0.2);
            border-color: #0ff;
        }

        .message-name {
            font-size: 11px;
            color: #0ff;
            margin-bottom: 4px;
        }

        .message-time {
            font-size: 9px;
            color: #aaa;
            margin-top: 6px;
            text-align: right;
        }

        .sticker {
            font-size: 48px;
            cursor: pointer;
            transition: 0.1s;
            display: inline-block;
        }

        .sticker:hover { transform: scale(1.2); }

        .voice-message {
            background: rgba(0, 0, 0, 0.5);
            border-radius: 30px;
            padding: 8px 16px;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
        }

        .input-area {
            padding: 16px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .message-input {
            flex: 1;
            background: rgba(20, 30, 45, 0.6);
            backdrop-filter: blur(8px);
            border: 1px solid #0ff;
            color: #fff;
            padding: 12px 18px;
            border-radius: 40px;
            outline: none;
            font-size: 14px;
        }

        .action-btn {
            background: rgba(0, 255, 200, 0.15);
            border: 1px solid #0ff;
            color: #0ff;
            padding: 10px 20px;
            border-radius: 40px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.2s;
        }

        .action-btn.recording {
            background: #f44;
            border-color: #f44;
            color: white;
            animation: pulse 0.8s infinite;
        }

        @keyframes pulse { 0% { opacity: 1; } 50% { opacity: 0.6; } 100% { opacity: 1; } }

        .sticker-panel {
            display: none;
            position: absolute;
            bottom: 90px;
            left: 20px;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 12px;
            gap: 12px;
            flex-wrap: wrap;
            width: 280px;
            z-index: 200;
            border: 1px solid #0ff;
        }

        .sticker-panel.show { display: flex; }

        .voice-call-panel {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(20px);
            border-radius: 48px;
            padding: 16px 24px;
            display: none;
            align-items: center;
            gap: 16px;
            z-index: 300;
            border: 1px solid #0ff;
        }

        .voice-call-panel.show { display: flex; }

        .call-end-btn {
            background: #f44;
            border: none;
            padding: 8px 20px;
            border-radius: 40px;
            color: white;
            cursor: pointer;
        }

        .connection-info {
            font-size: 9px;
            color: #8af;
            margin-top: 6px;
            word-break: break-all;
        }

        .mode-buttons {
            display: flex;
            gap: 8px;
            justify-content: center;
            margin-top: 10px;
        }

        .mode-btn {
            background: rgba(0, 255, 200, 0.15);
            border: 1px solid #0ff;
            color: #0ff;
            padding: 5px 12px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 11px;
        }

        .mode-btn.active {
            background: #0ff;
            color: #000;
        }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #111; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: #0ff; border-radius: 10px; }
    </style>
</head>
<body>
<div class="liquid-bg"></div>
<div class="liquid-overlay"></div>

<div class="messenger">
    <div class="sidebar">
        <div class="user-card glass">
            <div class="avatar-wrapper" id="avatarUploadBtn">
                <img id="myAvatarImg" class="avatar-img" src="">
            </div>
            <div class="nickname" id="myNickname">EgoUser</div>
            <div class="user-id" id="myUserId">ID: загрузка...</div>
            <div class="connection-info" id="connectionInfo">🌐 EgoMessenger 6767</div>
            <div class="mode-buttons">
                <button class="mode-btn" id="onlineModeBtn">🌍 ONLINE</button>
            </div>
            <div class="status" id="statusText">🟡 Инициализация...</div>
        </div>
        <div class="online-list glass">
            <div class="online-title">📡 ПОЛЬЗОВАТЕЛИ ОНЛАЙН</div>
            <div id="onlineListContainer"></div>
        </div>
    </div>

    <div class="chat-area">
        <div class="chat-header glass">
            <img id="chatAvatar" class="chat-header-avatar" src="">
            <div class="chat-header-name" id="chatName">Не выбран</div>
            <button class="voice-call-btn" id="voiceCallBtn">🎙️ Голосовой канал</button>
        </div>
        <div class="messages glass" id="messages">
            <div style="text-align:center; color:#8af; padding:40px">✨ Выберите пользователя ✨</div>
        </div>
        <div class="input-area glass">
            <input type="text" class="message-input" id="messageInput" placeholder="Сообщение...">
            <button class="action-btn" id="stickerBtn">😊 Стикеры</button>
            <button class="action-btn" id="voiceRecordBtn">🎤 Запись</button>
            <button class="action-btn" id="sendBtn">📤 Отправить</button>
        </div>
        <div class="sticker-panel" id="stickerPanel">
            <span class="sticker">😀</span> <span class="sticker">😂</span> <span class="sticker">😍</span>
            <span class="sticker">🔥</span> <span class="sticker">💀</span> <span class="sticker">🎉</span>
            <span class="sticker">❤️</span> <span class="sticker">👍</span> <span class="sticker">🤡</span>
            <span class="sticker">🍆</span> <span class="sticker">🥶</span> <span class="sticker">🤯</span>
        </div>
    </div>
</div>

<div class="voice-call-panel" id="voiceCallPanel">
    <span id="callAvatarText">🎙️</span>
    <span id="callStatus">Голосовой канал активен</span>
    <button class="call-end-btn" id="endCallBtn">Завершить</button>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/peerjs/1.5.0/peerjs.min.js"></script>
<script>
    // ========== EGO MESSENGER 6767 ==========
    let peer = null;
    let myId = null;
    let myName = localStorage.getItem('egomessenger_name') || 'Ego_' + Math.floor(Math.random() * 999);
    let myAvatarBase64 = localStorage.getItem('egomessenger_avatar') || null;
    let connections = {};
    let onlineUsers = {};
    let currentChatId = null;
    
    let mediaStream = null;
    let peerConnection = null;
    let activeCallWith = null;
    let mediaRecorder = null;
    let audioChunks = [];
    let isRecording = false;
    let audioElements = {};

    const myNickSpan = document.getElementById('myNickname');
    const myUserIdSpan = document.getElementById('myUserId');
    const myAvatarImg = document.getElementById('myAvatarImg');
    const onlineListDiv = document.getElementById('onlineListContainer');
    const messagesDiv = document.getElementById('messages');
    const chatNameSpan = document.getElementById('chatName');
    const chatAvatarImg = document.getElementById('chatAvatar');
    const statusTextSpan = document.getElementById('statusText');

    function updateMyAvatarUI() {
        if (myAvatarBase64) {
            myAvatarImg.src = myAvatarBase64;
        } else {
            myAvatarImg.src = `https://ui-avatars.com/api/?background=0ff&color=000&bold=true&size=100&name=${encodeURIComponent(myName)}`;
        }
    }
    updateMyAvatarUI();

    document.getElementById('avatarUploadBtn').addEventListener('click', () => {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = 'image/png, image/jpeg';
        input.onchange = (e) => {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (ev) => {
                    myAvatarBase64 = ev.target.result;
                    localStorage.setItem('egomessenger_avatar', myAvatarBase64);
                    updateMyAvatarUI();
                    broadcastMyInfo();
                };
                reader.readAsDataURL(file);
            }
        };
        input.click();
    });

    myNickSpan.innerText = myName;
    myNickSpan.onclick = () => {
        let newName = prompt('Новый ник:', myName);
        if (newName && newName.trim()) {
            myName = newName.trim();
            localStorage.setItem('egomessenger_name', myName);
            myNickSpan.innerText = myName;
            broadcastMyInfo();
        }
    };

    function broadcastMyInfo() {
        for (let id in connections) {
            sendToPeer(id, { type: 'info', name: myName, avatar: myAvatarBase64 });
        }
    }

    function sendToPeer(peerId, data) {
        if (connections[peerId] && connections[peerId].open) {
            connections[peerId].send(data);
        }
    }

    // ========== ONLINE РЕЖИМ ==========
    function initOnlineMode() {
        statusTextSpan.innerText = '🟡 Подключение к серверу...';
        
        if (peer) {
            try { peer.destroy(); } catch(e) {}
        }
        
        peer = new Peer({
            host: 'peerjs.com',
            port: 443,
            path: '/',
            secure: true,
            config: {
                iceServers: [
                    { urls: 'stun:stun.l.google.com:19302' },
                    { urls: 'stun:stun1.l.google.com:19302' }
                ]
            }
        });
        
        peer.on('open', (id) => {
            myId = id;
            myUserIdSpan.innerText = `ID: ${id.slice(0, 8)}...`;
            statusTextSpan.innerHTML = '🟢 ONLINE! Поделись своим ID с другом';
            document.getElementById('connectionInfo').innerHTML = `🌍 Твой ID: <strong style="color:#0ff">${id}</strong>`;
            
            setTimeout(() => {
                if (Object.keys(connections).length === 0) {
                    statusTextSpan.innerHTML = '🟢 Ждём подключения...<br><span style="font-size:10px">Отправь ID другу!</span>';
                }
            }, 2000);
        });
        
        peer.on('connection', (conn) => setupConnection(conn));
        peer.on('error', (err) {
            console.error('Error:', err);
            statusTextSpan.innerText = '🔴 Ошибка! Обнови страницу';
        });
    }
    
    function setupConnection(conn) {
        connections[conn.peer] = conn;
        conn.on('open', () => {
            conn.send({ type: 'info', name: myName, avatar: myAvatarBase64 });
            updateOnlineList();
        });
        conn.on('data', (data) => handleData(conn.peer, data));
        conn.on('close', () => {
            delete connections[conn.peer];
            delete onlineUsers[conn.peer];
            updateOnlineList();
            if (currentChatId === conn.peer) {
                messagesDiv.innerHTML = '<div style="text-align:center; color:#8af">Пользователь вышел</div>';
            }
        });
    }
    
    function handleData(peerId, data) {
        if (data.type === 'info') {
            onlineUsers[peerId] = { id: peerId, name: data.name, avatar: data.avatar };
            updateOnlineList();
        } else if (data.type === 'message') {
            addMessageToChat(data.name, data.avatar, data.text, data.time, false, data.isSticker);
            saveHistory(peerId, { name: data.name, avatar: data.avatar, text: data.text, time: data.time, isMe: false, isSticker: data.isSticker });
        } else if (data.type === 'voice_message') {
            addVoiceMessageToChat(peerId, data.name, data.avatar, data.audioBase64, data.time);
        } else if (data.type === 'call_offer') handleCallOffer(peerId, data);
        else if (data.type === 'call_answer') handleCallAnswer(data);
        else if (data.type === 'ice_candidate' && peerConnection) {
            peerConnection.addIceCandidate(new RTCIceCandidate(data.candidate));
        }
    }
    
    function updateOnlineList() {
        onlineListDiv.innerHTML = '';
        let count = 0;
        for (let id in connections) {
            if (id !== myId) {
                count++;
                let u = onlineUsers[id] || { id: id, name: 'Connected', avatar: null };
                let div = document.createElement('div');
                div.className = `user-item ${currentChatId === id ? 'active' : ''}`;
                div.innerHTML = `
                    <img class="user-avatar-small" src="${u.avatar || 'https://ui-avatars.com/api/?background=0ff&color=000&name='+encodeURIComponent(u.name)}">
                    <div class="user-name">${u.name || id.slice(0,8)}</div>
                    <div class="online-dot"></div>
                `;
                div.onclick = () => selectChat(id, u);
                onlineListDiv.appendChild(div);
            }
        }
        if (count === 0 && myId) {
            onlineListDiv.innerHTML = `<div style="color:#aaa; text-align:center; padding:20px">
                🔗 Твой ID: <strong style="color:#0ff">${myId}</strong><br>
                Отправь его другу!
            </div>`;
        } else if (count === 0) {
            onlineListDiv.innerHTML = '<div style="color:#aaa; text-align:center; padding:20px">👻 Никого нет</div>';
        }
    }
    
    function selectChat(id, user) {
        currentChatId = id;
        chatNameSpan.innerText = user.name || 'Unknown';
        chatAvatarImg.src = user.avatar || `https://ui-avatars.com/api/?background=0ff&color=000&name=${encodeURIComponent(user.name || id)}`;
        loadHistory(id);
    }
    
    function addMessageToChat(name, avatar, text, time, isMe, isSticker) {
        const msgDiv = document.createElement('div');
        msgDiv.className = `message ${isMe ? 'my' : ''}`;
        msgDiv.innerHTML = `
            <img class="message-avatar" src="${avatar || 'https://ui-avatars.com/api/?background=0ff&name='+encodeURIComponent(name)}">
            <div class="message-bubble">
                ${!isMe ? `<div class="message-name">${name}</div>` : ''}
                ${isSticker ? `<div style="font-size:48px">${text}</div>` : text}
                <div class="message-time">${time}</div>
            </div>
        `;
        messagesDiv.appendChild(msgDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }
    
    function addVoiceMessageToChat(peerId, name, avatar, audioBase64, time) {
        const msgDiv = document.createElement('div');
        msgDiv.className = 'message';
        msgDiv.innerHTML = `
            <img class="message-avatar" src="${avatar || 'https://ui-avatars.com/api/?background=0ff&name='+encodeURIComponent(name)}">
            <div class="message-bubble">
                <div class="message-name">${name}</div>
                <div class="voice-message" data-audio="${audioBase64}">🎤 Голосовое сообщение ▶️</div>
                <div class="message-time">${time}</div>
            </div>
        `;
        messagesDiv.appendChild(msgDiv);
        msgDiv.querySelector('.voice-message').onclick = () => { new Audio(audioBase64).play(); };
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }
    
    function sendMessage(text, isSticker = false) {
        if (!currentChatId || !connections[currentChatId]) { 
            alert('Пользователь не в сети'); 
            return; 
        }
        let time = new Date().toLocaleTimeString();
        sendToPeer(currentChatId, { type: 'message', name: myName, avatar: myAvatarBase64, text, time, isSticker });
        addMessageToChat(myName, myAvatarBase64, text, time, true, isSticker);
        saveHistory(currentChatId, { name: myName, avatar: myAvatarBase64, text, time, isMe: true, isSticker });
    }
    
    function saveHistory(peerId, msg) {
        let key = `ego_chat_${myId}_${peerId}`;
        let history = JSON.parse(localStorage.getItem(key) || '[]');
        history.push(msg);
        if (history.length > 200) history.shift();
        localStorage.setItem(key, JSON.stringify(history));
    }
    
    function loadHistory(peerId) {
        messagesDiv.innerHTML = '';
        let key = `ego_chat_${myId}_${peerId}`;
        let history = JSON.parse(localStorage.getItem(key) || '[]');
        history.forEach(msg => {
            addMessageToChat(msg.name, msg.avatar, msg.text, msg.time, msg.isMe, msg.isSticker);
        });
        if (history.length === 0) messagesDiv.innerHTML = '<div style="text-align:center; color:#8af">💬 Начните диалог</div>';
    }
    
    // === ГОЛОСОВЫЕ СООБЩЕНИЯ ===
    async function startVoiceRecording() {
        if (isRecording) return;
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        mediaRecorder = new MediaRecorder(stream);
        audioChunks = [];
        mediaRecorder.ondataavailable = e => audioChunks.push(e.data);
        mediaRecorder.onstop = async () => {
            const blob = new Blob(audioChunks, { type: 'audio/webm' });
            const reader = new FileReader();
            reader.onloadend = () => {
                if (currentChatId && connections[currentChatId]) {
                    let time = new Date().toLocaleTimeString();
                    sendToPeer(currentChatId, {
                        type: 'voice_message', name: myName, avatar: myAvatarBase64,
                        audioBase64: reader.result, time
                    });
                    addMessageToChat(myName, myAvatarBase64, '🎤 Голосовое сообщение', time, true, false);
                }
            };
            reader.readAsDataURL(blob);
            stream.getTracks().forEach(t => t.stop());
            isRecording = false;
            const btn = document.getElementById('voiceRecordBtn');
            btn.classList.remove('recording');
            btn.innerHTML = '🎤 Запись';
        };
        mediaRecorder.start();
        isRecording = true;
        const btn = document.getElementById('voiceRecordBtn');
        btn.classList.add('recording');
        btn.innerHTML = '⏹️ Стоп';
        setTimeout(() => { if (isRecording) mediaRecorder.stop(); }, 30000);
    }
    function stopVoiceRecording() { if (mediaRecorder && isRecording) mediaRecorder.stop(); }
    document.getElementById('voiceRecordBtn').onclick = () => { if (isRecording) stopVoiceRecording(); else startVoiceRecording(); };
    
    // === ГОЛОСОВОЙ КАНАЛ ===
    async function startVoiceCall() {
        if (!currentChatId) { alert('Выберите собеседника'); return; }
        if (activeCallWith) { alert('Уже в звонке'); return; }
        activeCallWith = currentChatId;
        document.getElementById('voiceCallPanel').classList.add('show');
        document.getElementById('voiceCallBtn').classList.add('active');
        document.getElementById('voiceCallBtn').innerHTML = '🔴 В звонке';
        peerConnection = new RTCPeerConnection({ iceServers: [{ urls: 'stun:stun.l.google.com:19302' }] });
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        mediaStream = stream;
        stream.getTracks().forEach(t => peerConnection.addTrack(t, stream));
        peerConnection.ontrack = e => {
            if (!audioElements[currentChatId]) {
                let audio = new Audio();
                audio.srcObject = e.streams[0];
                audio.autoplay = true;
                audioElements[currentChatId] = audio;
            }
        };
        peerConnection.onicecandidate = e => {
            if (e.candidate) sendToPeer(currentChatId, { type: 'ice_candidate', candidate: e.candidate });
        };
        const offer = await peerConnection.createOffer();
        await peerConnection.setLocalDescription(offer);
        sendToPeer(currentChatId, { type: 'call_offer', offer });
    }

    function handleCallOffer(peerId, data) {
        if (activeCallWith) { sendToPeer(peerId, { type: 'call_busy' }); return; }
        if (confirm(`📞 Входящий звонок от ${onlineUsers[peerId]?.name || peerId}?`)) {
            activeCallWith = peerId;
            document.getElementById('voiceCallPanel').classList.add('show');
            document.getElementById('voiceCallBtn').classList.add('active');
            answerCall(peerId, data.offer);
        }
    }
    
    async function answerCall(peerId, offer) {
        peerConnection = new RTCPeerConnection({ iceServers: [{ urls: 'stun:stun.l.google.com:19302' }] });
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        mediaStream = stream;
        stream.getTracks().forEach(t => peerConnection.addTrack(t, stream));
        peerConnection.ontrack = e => {
            if (!audioElements[peerId]) {
                let audio = new Audio();
                audio.srcObject = e.streams[0];
                audio.autoplay = true;
                audioElements[peerId] = audio;
            }
        };
        peerConnection.onicecandidate = e => {
            if (e.candidate) sendToPeer(peerId, { type: 'ice_candidate', candidate: e.candidate });
        };
        await peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
        const answer = await peerConnection.createAnswer();
        await peerConnection.setLocalDescription(answer);
        sendToPeer(peerId, { type: 'call_answer', answer: peerConnection.localDescription });
    }
    
    function handleCallAnswer(data) { if (peerConnection) peerConnection.setRemoteDescription(new RTCSessionDescription(data.answer)); }
    
    function endCall() {
        if (peerConnection) peerConnection.close();
        if (mediaStream) mediaStream.getTracks().forEach(t => t.stop());
        if (activeCallWith && audioElements[activeCallWith]) audioElements[activeCallWith].pause();
        activeCallWith = null; peerConnection = null; mediaStream = null;
        document.getElementById('voiceCallPanel').classList.remove('show');
        document.getElementById('voiceCallBtn').classList.remove('active');
        document.getElementById('voiceCallBtn').innerHTML = '🎙️ Голосовой канал';
    }
    
    document.getElementById('voiceCallBtn').onclick = () => { if (activeCallWith) endCall(); else startVoiceCall(); };
    document.getElementById('endCallBtn').onclick = () => endCall();
    
    // === UI ===
    document.getElementById('sendBtn').onclick = () => {
        let inp = document.getElementById('messageInput');
        if (inp.value.trim()) { sendMessage(inp.value.trim(), false); inp.value = ''; }
    };
    document.getElementById('messageInput').addEventListener('keypress', e => { if (e.key === 'Enter') document.getElementById('sendBtn').click(); });
    document.getElementById('stickerBtn').onclick = () => document.getElementById('stickerPanel').classList.toggle('show');
    document.querySelectorAll('.sticker').forEach(s => {
        s.onclick = () => { sendMessage(s.innerText, true); document.getElementById('stickerPanel').classList.remove('show'); };
    });
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.sticker-btn') && !e.target.closest('.sticker-panel'))
            document.getElementById('stickerPanel').classList.remove('show');
    });
    
    // ЗАПУСК
    initOnlineMode();
    setInterval(() => {
        if (myId && connections) updateOnlineList();
    }, 3000);
</script>
</body>
</html>
