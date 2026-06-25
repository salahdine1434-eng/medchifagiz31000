// متغيرات عامة
let currentLanguage = 'ar';
let isDarkMode = false;
let currentInterface = 'home';
let currentChatUser = null;
let chatMessages = {};

// بيانات وهمية للمحادثات
const chatUsersData = {
    patients: [
        {
            id: 'p1',
            name: 'محمد علي',
            avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%234A90E2\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eم%3C/text%3E%3C/svg%3E',
            status: 'متصل الآن',
            lastMessage: 'شكراً دكتور على المتابعة',
            time: '10:30',
            unread: 2
        },
        {
            id: 'p2',
            name: 'فاطمة حسن',
            avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%2350C878\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eف%3C/text%3E%3C/svg%3E',
            status: 'آخر ظهور منذ 5 دقائق',
            lastMessage: 'هل يمكن تغيير الموعد؟',
            time: 'أمس',
            unread: 0
        },
        {
            id: 'p3',
            name: 'أحمد يوسف',
            avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%23FF6B6B\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eأ%3C/text%3E%3C/svg%3E',
            status: 'متصل الآن',
            lastMessage: 'متى موعد الفحص القادم؟',
            time: '14:20',
            unread: 1
        }
    ],
    doctors: [
        {
            id: 'd1',
            name: 'د. خالد محمود',
            avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%23FF6B6B\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eد%3C/text%3E%3C/svg%3E',
            status: 'متصل الآن',
            lastMessage: 'بخصوص المريض المشترك',
            time: '14:20',
            unread: 1
        },
        {
            id: 'd2',
            name: 'د. سارة أحمد',
            avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%23FFA500\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eد%3C/text%3E%3C/svg%3E',
            status: 'آخر ظهور منذ ساعة',
            lastMessage: 'شكراً على الاستشارة',
            time: 'أمس',
            unread: 0
        }
    ]
};

// رسائل وهمية
chatMessages = {
    'p1': [
        { sender: 'received', text: 'السلام عليكم دكتور', time: '10:15' },
        { sender: 'sent', text: 'وعليكم السلام، كيف حالك؟', time: '10:16' },
        { sender: 'received', text: 'الحمد لله، شعرت بتحسن كبير بعد الدواء', time: '10:20' },
        { sender: 'sent', text: 'ممتاز! استمر على الدواء كما وصفته لك', time: '10:22' },
        { sender: 'received', text: 'شكراً دكتور على المتابعة', time: '10:30' }
    ],
    'p2': [
        { sender: 'received', text: 'مساء الخير دكتور', time: 'أمس 15:30' },
        { sender: 'sent', text: 'مساء النور، تفضلي', time: 'أمس 15:32' },
        { sender: 'received', text: 'هل يمكن تغيير الموعد؟', time: 'أمس 15:35' }
    ],
    'p3': [
        { sender: 'received', text: 'دكتور، متى موعد الفحص القادم؟', time: '14:20' },
        { sender: 'sent', text: 'موعدك يوم الخميس الساعة 10 صباحاً', time: '14:25' }
    ],
    'd1': [
        { sender: 'received', text: 'مرحباً د. أحمد', time: '14:00' },
        { sender: 'sent', text: 'أهلاً د. خالد، كيف حالك؟', time: '14:05' },
        { sender: 'received', text: 'بخصوص المريض المشترك، هل استطعت فحصه؟', time: '14:20' }
    ],
    'd2': [
        { sender: 'received', text: 'شكراً على الاستشارة', time: 'أمس 16:00' },
        { sender: 'sent', text: 'العفو، دائماً في الخدمة', time: 'أمس 16:05' }
    ]
};

// بيانات السجل الطبي الوهمية
const medicalRecordsData = {
    'p1': {
        name: 'محمد علي أحمد',
        age: 38,
        gender: 'ذكر',
        bloodType: 'O+',
        phone: '0555111222',
        email: 'mohamed.ali@email.com',
        address: 'حي الوحدة، شارع الجمهورية',
        avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'100\' height=\'100\'%3E%3Ccircle cx=\'50\' cy=\'50\' r=\'50\' fill=\'%234A90E2\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'40\' font-family=\'Arial\'%3Eم%3C/text%3E%3C/svg%3E',
        condition: 'حالة عاجلة',
        currentMedications: [
            'أموكسيسيلين 500mg - 3 مرات يومياً',
            'باراسيتامول 500mg - عند الحاجة',
            'فيتامين D 1000IU - مرة يومياً'
        ],
        allergies: [
            'حساسية من البنسلين',
            'حساسية من الفول السوداني'
        ],
        medicalHistory: [
            'التهاب اللوزتين المزمن - 2020',
            'كسر في الذراع اليسرى - 2018',
            'التهاب المعدة - 2019'
        ],
        visits: [
            {
                date: '2026-02-01',
                diagnosis: 'التهاب في الحلق',
                treatment: 'مضاد حيوي + مسكن للألم',
                notes: 'المريض يشكو من ألم شديد في الحلق وصعوبة في البلع'
            },
            {
                date: '2026-01-15',
                diagnosis: 'فحص دوري',
                treatment: 'فيتامينات',
                notes: 'الفحص العام جيد، ننصح بالمتابعة الدورية'
            }
        ],
        vitalSigns: {
            bloodPressure: '120/80',
            heartRate: '72 نبضة/دقيقة',
            temperature: '37.2°C',
            weight: '75 كجم',
            height: '175 سم'
        }
    },
    'p2': {
        name: 'فاطمة حسن محمد',
        age: 35,
        gender: 'أنثى',
        bloodType: 'A+',
        phone: '0555222333',
        email: 'fatima.hassan@email.com',
        address: 'حي السلام، شارع الملك فيصل',
        avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'100\' height=\'100\'%3E%3Ccircle cx=\'50\' cy=\'50\' r=\'50\' fill=\'%2350C878\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'40\' font-family=\'Arial\'%3Eف%3C/text%3E%3C/svg%3E',
        condition: 'متابعة دورية',
        currentMedications: [
            'حبوب منع الحمل',
            'فيتامين B12 - مرة يومياً'
        ],
        allergies: [
            'لا توجد حساسية معروفة'
        ],
        medicalHistory: [
            'عملية جراحية في الزائدة الدودية - 2015'
        ],
        visits: [
            {
                date: '2026-01-20',
                diagnosis: 'فحص روتيني',
                treatment: 'فيتامينات',
                notes: 'الصحة العامة ممتازة'
            }
        ],
        vitalSigns: {
            bloodPressure: '115/75',
            heartRate: '68 نبضة/دقيقة',
            temperature: '36.8°C',
            weight: '62 كجم',
            height: '165 سم'
        }
    }
};

// بيانات التحاليل الطبية الوهمية
const labResultsData = {
    patientName: 'محمد علي أحمد',
    patientId: 'P-2026-001',
    testDate: '2026-02-07',
    labName: 'مختبر الشفاء الطبي',
    tests: [
        {
            category: 'تحليل الدم الشامل (CBC)',
            results: [
                { name: 'كريات الدم البيضاء (WBC)', value: '7.2', unit: '×10³/µL', range: '4.0-11.0', status: 'normal' },
                { name: 'كريات الدم الحمراء (RBC)', value: '5.1', unit: '×10⁶/µL', range: '4.5-5.9', status: 'normal' },
                { name: 'الهيموجلوبين (Hb)', value: '14.5', unit: 'g/dL', range: '13.0-17.0', status: 'normal' },
                { name: 'الهيماتوكريت (HCT)', value: '43.2', unit: '%', range: '38.0-50.0', status: 'normal' },
                { name: 'الصفائح الدموية', value: '245', unit: '×10³/µL', range: '150-400', status: 'normal' }
            ]
        },
        {
            category: 'وظائف الكلى',
            results: [
                { name: 'اليوريا (BUN)', value: '18', unit: 'mg/dL', range: '7-20', status: 'normal' },
                { name: 'الكرياتينين', value: '1.1', unit: 'mg/dL', range: '0.7-1.3', status: 'normal' },
                { name: 'حمض اليوريك', value: '5.8', unit: 'mg/dL', range: '3.5-7.2', status: 'normal' }
            ]
        },
        {
            category: 'وظائف الكبد',
            results: [
                { name: 'ALT (SGPT)', value: '28', unit: 'U/L', range: '0-41', status: 'normal' },
                { name: 'AST (SGOT)', value: '32', unit: 'U/L', range: '0-40', status: 'normal' },
                { name: 'البيليروبين الكلي', value: '0.8', unit: 'mg/dL', range: '0.1-1.2', status: 'normal' }
            ]
        },
        {
            category: 'السكر والدهون',
            results: [
                { name: 'الجلوكوز (صائم)', value: '95', unit: 'mg/dL', range: '70-100', status: 'normal' },
                { name: 'الكوليسترول الكلي', value: '185', unit: 'mg/dL', range: '<200', status: 'normal' },
                { name: 'الدهون الثلاثية', value: '140', unit: 'mg/dL', range: '<150', status: 'normal' },
                { name: 'HDL (الكوليسترول الجيد)', value: '55', unit: 'mg/dL', range: '>40', status: 'normal' },
                { name: 'LDL (الكوليسترول الضار)', value: '102', unit: 'mg/dL', range: '<130', status: 'normal' }
            ]
        }
    ]
};

// تهيئة التطبيق
document.addEventListener('DOMContentLoaded', function() {
    initializeChart();
    initializeLanguage();
    setDefaultDates();
    initializeChatInputs();
});

// التبديل بين الواجهات
function switchInterface(interfaceName) {
    document.querySelectorAll('.interface').forEach(interface => {
        interface.classList.remove('active');
    });
    
    document.querySelectorAll('.nav-item').forEach(item => {
        item.classList.remove('active');
    });
    
    document.getElementById(interfaceName + '-interface').classList.add('active');
    event.currentTarget.classList.add('active');
    
    closeAllCardContents();
    currentInterface = interfaceName;
}

// التبديل بين البطاقات في الواجهة الرئيسية
function toggleCard(cardId) {
    const cardContent = document.getElementById(cardId);
    const allCards = document.querySelectorAll('.card-content');
    const allMainCards = document.querySelectorAll('.main-card');
    
    allCards.forEach(card => {
        if (card.id !== cardId) {
            card.classList.remove('active');
        }
    });
    
    allMainCards.forEach(card => {
        card.classList.remove('active');
    });
    
    if (cardContent.classList.contains('active')) {
        cardContent.classList.remove('active');
    } else {
        cardContent.classList.add('active');
        event.currentTarget.classList.add('active');
        
        setTimeout(() => {
            cardContent.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }, 100);
    }
}

// إغلاق محتوى البطاقة
function closeCardContent() {
    const allCards = document.querySelectorAll('.card-content');
    const allMainCards = document.querySelectorAll('.main-card');
    
    allCards.forEach(card => {
        card.classList.remove('active');
    });
    
    allMainCards.forEach(card => {
        card.classList.remove('active');
    });
}

// إغلاق جميع المحتويات
function closeAllCardContents() {
    closeCardContent();
    closeAIContent();
    closeMessageContent();
    closeServiceContent();
    closeMedicalRecordModal();
}

// التبديل بين بطاقات الذكاء الاصطناعي
function toggleAICard(cardId) {
    const cardContent = document.getElementById(cardId);
    const allContents = document.querySelectorAll('.ai-content');
    const allCards = document.querySelectorAll('.ai-card');
    
    allContents.forEach(content => {
        if (content.id !== cardId) {
            content.classList.remove('active');
        }
    });
    
    allCards.forEach(card => {
        card.classList.remove('active');
    });
    
    if (cardContent.classList.contains('active')) {
        cardContent.classList.remove('active');
    } else {
        cardContent.classList.add('active');
        event.currentTarget.classList.add('active');
        
        setTimeout(() => {
            cardContent.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }, 100);
    }
}

// إغلاق محتوى الذكاء الاصطناعي
function closeAIContent() {
    const allContents = document.querySelectorAll('.ai-content');
    const allCards = document.querySelectorAll('.ai-card');
    
    allContents.forEach(content => {
        content.classList.remove('active');
    });
    
    allCards.forEach(card => {
        card.classList.remove('active');
    });
}

// تبديل المساعد الذكي
function toggleAssistant() {
    const assistantChat = document.getElementById('assistantChat');
    assistantChat.classList.toggle('active');
}

// إغلاق المساعد الذكي
function closeAssistant() {
    const assistantChat = document.getElementById('assistantChat');
    assistantChat.classList.remove('active');
}

// التبديل بين بطاقات المحادثات - تحديث مع واجهة Messenger كاملة
function toggleMessageCard(cardId) {
    const cardContent = document.getElementById(cardId);
    const allContents = document.querySelectorAll('.chat-content');
    const allCards = document.querySelectorAll('.message-card');
    
    allContents.forEach(content => {
        if (content.id !== cardId) {
            content.classList.remove('active');
        }
    });
    
    allCards.forEach(card => {
        card.classList.remove('active');
    });
    
    if (cardContent.classList.contains('active')) {
        cardContent.classList.remove('active');
        currentChatUser = null;
    } else {
        cardContent.classList.add('active');
        event.currentTarget.classList.add('active');
        
        // تحميل واجهة المحادثة الكاملة
        const chatType = cardId === 'patientChats' ? 'patients' : 'doctors';
        loadFullChatInterface(cardContent, chatType);
        
        setTimeout(() => {
            cardContent.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }, 100);
    }
}

// تحميل واجهة المحادثة الكاملة
function loadFullChatInterface(container, type) {
    const users = chatUsersData[type];
    
    const chatHTML = `
        <div class="full-chat-interface">
            <div class="chat-sidebar">
                <div class="chat-sidebar-header">
                    <h3>${type === 'patients' ? 'المرضى' : 'الأطباء'}</h3>
                    <button onclick="closeMessageContent()"><i class="fas fa-times"></i></button>
                </div>
                <div class="chat-search">
                    <input type="text" placeholder="بحث..." onkeyup="searchChats(this.value, '${type}')">
                </div>
                <div class="chat-list-container" id="chatListContainer-${type}">
                    ${users.map(user => `
                        <div class="chat-list-item" data-user-id="${user.id}" onclick="selectChatUser('${user.id}', '${type}')">
                            <img src="${user.avatar}" alt="${user.name}">
                            <div class="chat-list-item-info">
                                <h4>${user.name}</h4>
                                <p>${user.lastMessage}</p>
                            </div>
                            <div class="chat-meta">
                                <span class="time">${user.time}</span>
                                ${user.unread ? `<span class="unread-badge">${user.unread}</span>` : ''}
                            </div>
                        </div>
                    `).join('')}
                </div>
            </div>
            <div class="chat-main" id="chatMain-${type}">
                <div class="no-chat-selected">
                    <i class="fas fa-comments"></i>
                    <p>اختر محادثة لبدء المراسلة</p>
                </div>
            </div>
        </div>
    `;
    
    container.innerHTML = chatHTML;
}

// اختيار مستخدم للمحادثة
function selectChatUser(userId, type) {
    currentChatUser = { id: userId, type: type };
    
    // تحديث القائمة الجانبية
    document.querySelectorAll(`#chatListContainer-${type} .chat-list-item`).forEach(item => {
        item.classList.remove('active');
    });
    
    const selectedItem = document.querySelector(`#chatListContainer-${type} [data-user-id="${userId}"]`);
    if (selectedItem) {
        selectedItem.classList.add('active');
    }
    
    // تحميل المحادثة
    loadChatMessages(userId, type);
}

// تحميل رسائل المحادثة
function loadChatMessages(userId, type) {
    const users = chatUsersData[type];
    const user = users.find(u => u.id === userId);
    const messages = chatMessages[userId] || [];
    
    const chatMainHTML = `
        <div class="chat-main-header">
            <img src="${user.avatar}" alt="${user.name}">
            <div class="chat-main-header-info">
                <h3>${user.name}</h3>
                <p>${user.status}</p>
            </div>
        </div>
        <div class="chat-main-messages" id="chatMainMessages-${userId}">
            ${messages.map(msg => `
                <div class="chat-message ${msg.sender}">
                    <img src="${msg.sender === 'sent' ? 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'35\' height=\'35\'%3E%3Ccircle cx=\'17.5\' cy=\'17.5\' r=\'17.5\' fill=\'%234A90E2\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'14\' font-family=\'Arial\'%3Eد%3C/text%3E%3C/svg%3E' : user.avatar}" class="chat-message-avatar" alt="avatar">
                    <div>
                        <div class="chat-message-bubble">
                            ${msg.text}
                        </div>
                        <div class="chat-message-time">${msg.time}</div>
                    </div>
                </div>
            `).join('')}
        </div>
        <div class="chat-main-input">
            <div class="chat-main-input-field">
                <span class="chat-input-icon"><i class="fas fa-smile"></i></span>
                <input type="text" placeholder="اكتب رسالة..." id="chatInput-${userId}" onkeypress="handleChatEnter(event, '${userId}')">
                <span class="chat-input-icon"><i class="fas fa-paperclip"></i></span>
            </div>
            <button class="chat-send-btn" onclick="sendChatMessage('${userId}')">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    `;
    
    const chatMain = document.getElementById(`chatMain-${type}`);
    if (chatMain) {
        chatMain.innerHTML = chatMainHTML;
        
        // التمرير لآخر رسالة
        setTimeout(() => {
            const messagesContainer = document.getElementById(`chatMainMessages-${userId}`);
            if (messagesContainer) {
                messagesContainer.scrollTop = messagesContainer.scrollHeight;
            }
        }, 100);
    }
}

// إرسال رسالة في المحادثة
function sendChatMessage(userId) {
    const input = document.getElementById(`chatInput-${userId}`);
    if (!input) return;
    
    const messageText = input.value.trim();
    
    if (!messageText) return;
    
    // إضافة الرسالة للبيانات
    if (!chatMessages[userId]) {
        chatMessages[userId] = [];
    }
    
    const now = new Date();
    const time = now.getHours() + ':' + (now.getMinutes() < 10 ? '0' : '') + now.getMinutes();
    
    chatMessages[userId].push({
        sender: 'sent',
        text: messageText,
        time: time
    });
    
    // إضافة الرسالة للواجهة
    const messagesContainer = document.getElementById(`chatMainMessages-${userId}`);
    if (!messagesContainer) return;
    
    const user = [...chatUsersData.patients, ...chatUsersData.doctors].find(u => u.id === userId);
    
    const messageHTML = `
        <div class="chat-message sent">
            <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='35' height='35'%3E%3Ccircle cx='17.5' cy='17.5' r='17.5' fill='%234A90E2'/%3E%3Ctext x='50%25' y='50%25' text-anchor='middle' dy='.3em' fill='white' font-size='14' font-family='Arial'%3Eد%3C/text%3E%3C/svg%3E" class="chat-message-avatar" alt="avatar">
            <div>
                <div class="chat-message-bubble">
                    ${messageText}
                </div>
                <div class="chat-message-time">${time}</div>
            </div>
        </div>
    `;
    
    messagesContainer.insertAdjacentHTML('beforeend', messageHTML);
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
    
    input.value = '';
    
    // محاكاة رد تلقائي
    setTimeout(() => {
        const autoReply = getAutoReply();
        chatMessages[userId].push({
            sender: 'received',
            text: autoReply,
            time: time
        });
        
        const replyHTML = `
            <div class="chat-message received">
                <img src="${user.avatar}" class="chat-message-avatar" alt="avatar">
                <div>
                    <div class="chat-message-bubble">
                        ${autoReply}
                    </div>
                    <div class="chat-message-time">${time}</div>
                </div>
            </div>
        `;
        
        messagesContainer.insertAdjacentHTML('beforeend', replyHTML);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }, 2000);
}

// ردود تلقائية عشوائية
function getAutoReply() {
    const replies = [
        'شكراً دكتور',
        'حسناً، سأتبع تعليماتك',
        'متى الموعد القادم؟',
        'هل يمكنني أخذ الدواء مع الطعام؟',
        'الحمد لله، أشعر بتحسن',
        'سأحضر في الموعد المحدد',
        'شكراً على اهتمامك'
    ];
    return replies[Math.floor(Math.random() * replies.length)];
}

// التعامل مع Enter في المحادثة
function handleChatEnter(event, userId) {
    if (event.key === 'Enter') {
        sendChatMessage(userId);
    }
}

// بحث في المحادثات
function searchChats(query, type) {
    const items = document.querySelectorAll(`#chatListContainer-${type} .chat-list-item`);
    const searchLower = query.toLowerCase();
    
    items.forEach(item => {
        const name = item.querySelector('h4').textContent.toLowerCase();
        if (name.includes(searchLower)) {
            item.style.display = 'flex';
        } else {
            item.style.display = 'none';
        }
    });
}

// إغلاق محتوى المحادثات
function closeMessageContent() {
    const allContents = document.querySelectorAll('.chat-content');
    const allCards = document.querySelectorAll('.message-card');
    
    allContents.forEach(content => {
        content.classList.remove('active');
    });
    
    allCards.forEach(card => {
        card.classList.remove('active');
    });
    
    currentChatUser = null;
}

// عرض السجل الطبي
function showMedicalRecord(patientId) {
    const record = medicalRecordsData[patientId];
    if (!record) return;
    
    const modalHTML = `
        <div class="medical-record-modal active" id="medicalRecordModal" onclick="closeModalOnBackdrop(event)">
            <div class="medical-record-content" onclick="event.stopPropagation()">
                <div class="medical-record-header">
                    <h2>السجل الطبي</h2>
                    <button class="close-modal-btn" onclick="closeMedicalRecordModal()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="medical-record-body">
                    <div class="patient-header-info">
                        <img src="${record.avatar}" alt="${record.name}" class="patient-avatar-large">
                        <div class="patient-basic-info">
                            <h3>${record.name}</h3>
                            <p><i class="fas fa-calendar"></i> ${record.age} سنة | ${record.gender}</p>
                            <p><i class="fas fa-tint"></i> فصيلة الدم: ${record.bloodType}</p>
                            <p><i class="fas fa-phone"></i> ${record.phone}</p>
                            <p><i class="fas fa-envelope"></i> ${record.email}</p>
                            <span class="info-badge">${record.condition}</span>
                        </div>
                    </div>
                    
                    <div class="record-section">
                        <h3><i class="fas fa-heartbeat"></i> العلامات الحيوية</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <label>ضغط الدم</label>
                                <div class="value">${record.vitalSigns.bloodPressure}</div>
                            </div>
                            <div class="info-item">
                                <label>معدل النبض</label>
                                <div class="value">${record.vitalSigns.heartRate}</div>
                            </div>
                            <div class="info-item">
                                <label>درجة الحرارة</label>
                                <div class="value">${record.vitalSigns.temperature}</div>
                            </div>
                            <div class="info-item">
                                <label>الوزن</label>
                                <div class="value">${record.vitalSigns.weight}</div>
                            </div>
                            <div class="info-item">
                                <label>الطول</label>
                                <div class="value">${record.vitalSigns.height}</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="record-section">
                        <h3><i class="fas fa-pills"></i> الأدوية الحالية</h3>
                        <ul class="medications-list">
                            ${record.currentMedications.map(med => `
                                <li><i class="fas fa-capsules"></i> ${med}</li>
                            `).join('')}
                        </ul>
                    </div>
                    
                    <div class="record-section">
                        <h3><i class="fas fa-exclamation-triangle"></i> الحساسية</h3>
                        <ul class="allergies-list">
                            ${record.allergies.map(allergy => `
                                <li><i class="fas fa-ban"></i> ${allergy}</li>
                            `).join('')}
                        </ul>
                    </div>
                    
                    <div class="record-section">
                        <h3><i class="fas fa-history"></i> التاريخ المرضي</h3>
                        <ul class="history-list">
                            ${record.medicalHistory.map(history => `
                                <li><i class="fas fa-file-medical"></i> ${history}</li>
                            `).join('')}
                        </ul>
                    </div>
                    
                    <div class="record-section">
                        <h3><i class="fas fa-calendar-alt"></i> سجل الزيارات</h3>
                        <div class="visit-timeline">
                            ${record.visits.map(visit => `
                                <div class="visit-item">
                                    <div class="visit-date">${visit.date}</div>
                                    <div class="visit-details">
                                        <p><strong>التشخيص:</strong> ${visit.diagnosis}</p>
                                        <p><strong>العلاج:</strong> ${visit.treatment}</p>
                                        <p><strong>ملاحظات:</strong> ${visit.notes}</p>
                                    </div>
                                </div>
                            `).join('')}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // إزالة أي modal موجود
    const existingModal = document.getElementById('medicalRecordModal');
    if (existingModal) {
        existingModal.remove();
    }
    
    document.body.insertAdjacentHTML('beforeend', modalHTML);
}

// إغلاق نافذة السجل الطبي
function closeMedicalRecordModal() {
    const modal = document.getElementById('medicalRecordModal');
    if (modal) {
        modal.classList.remove('active');
        setTimeout(() => modal.remove(), 300);
    }
}

// إغلاق عند النقر على الخلفية
function closeModalOnBackdrop(event) {
    if (event.target.classList.contains('medical-record-modal')) {
        closeMedicalRecordModal();
    }
}

// إغلاق محتوى الخدمات
function closeServiceContent() {
    const allContents = document.querySelectorAll('.service-content');
    const allCards = document.querySelectorAll('.service-card');
    
    allContents.forEach(content => {
        content.classList.remove('active');
    });
    
    allCards.forEach(card => {
        card.classList.remove('active');
    });
}

// التبديل بين التنبيهات
function toggleNotifications() {
    const notificationsPanel = document.getElementById('notificationsPanel');
    notificationsPanel.classList.toggle('active');
}

// إغلاق التنبيهات
function closeNotifications() {
    const notificationsPanel = document.getElementById('notificationsPanel');
    notificationsPanel.classList.remove('active');
}

// التبديل بين اللغات
function toggleLanguage() {
    const languages = ['ar', 'fr', 'en'];
    const currentIndex = languages.indexOf(currentLanguage);
    const nextIndex = (currentIndex + 1) % languages.length;
    currentLanguage = languages[nextIndex];
    
    if (currentLanguage === 'ar') {
        document.documentElement.setAttribute('dir', 'rtl');
        document.documentElement.setAttribute('lang', 'ar');
    } else {
        document.documentElement.setAttribute('dir', 'ltr');
        document.documentElement.setAttribute('lang', currentLanguage);
    }
    
    updateTexts();
}

// تحديث النصوص حسب اللغة
function updateTexts() {
    const elements = document.querySelectorAll('[data-ar]');
    
    elements.forEach(element => {
        const arText = element.getAttribute('data-ar');
        const frText = element.getAttribute('data-fr');
        const enText = element.getAttribute('data-en');
        
        if (currentLanguage === 'ar' && arText) {
            element.textContent = arText;
        } else if (currentLanguage === 'fr' && frText) {
            element.textContent = frText;
        } else if (currentLanguage === 'en' && enText) {
            element.textContent = enText;
        }
    });
    
    const placeholderElements = document.querySelectorAll('[data-ar-placeholder]');
    placeholderElements.forEach(element => {
        const arPlaceholder = element.getAttribute('data-ar-placeholder');
        const frPlaceholder = element.getAttribute('data-fr-placeholder');
        const enPlaceholder = element.getAttribute('data-en-placeholder');
        
        if (currentLanguage === 'ar' && arPlaceholder) {
            element.setAttribute('placeholder', arPlaceholder);
        } else if (currentLanguage === 'fr' && frPlaceholder) {
            element.setAttribute('placeholder', frPlaceholder);
        } else if (currentLanguage === 'en' && enPlaceholder) {
            element.setAttribute('placeholder', enPlaceholder);
        }
    });
}

// تهيئة اللغة
function initializeLanguage() {
    currentLanguage = 'ar';
    document.documentElement.setAttribute('dir', 'rtl');
    document.documentElement.setAttribute('lang', 'ar');
}

// التبديل بين الوضع النهاري والليلي
function toggleTheme() {
    isDarkMode = !isDarkMode;
    document.body.classList.toggle('dark-mode');
    
    const themeIcon = document.querySelector('.theme-toggle i');
    if (isDarkMode) {
        themeIcon.classList.remove('fa-sun');
        themeIcon.classList.add('fa-moon');
    } else {
        themeIcon.classList.remove('fa-moon');
        themeIcon.classList.add('fa-sun');
    }
}

// تهيئة الرسم البياني
function initializeChart() {
    const ctx = document.getElementById('weeklyChart');
    if (!ctx) return;
    
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت'],
            datasets: [{
                label: 'عدد المرضى',
                data: [12, 19, 15, 17, 14, 10, 8],
                backgroundColor: 'rgba(74, 144, 226, 0.6)',
                borderColor: 'rgba(74, 144, 226, 1)',
                borderWidth: 2,
                borderRadius: 10
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 5
                    }
                }
            }
        }
    });
}

// تعيين التواريخ الافتراضية
function setDefaultDates() {
    const dateInputs = document.querySelectorAll('.booking-date');
    const today = new Date().toISOString().split('T')[0];
    
    dateInputs.forEach(input => {
        input.value = today;
    });
    
    const timeInputs = document.querySelectorAll('.booking-time');
    timeInputs.forEach(input => {
        input.value = '09:00';
    });
}

// تهيئة حقول الإدخال في المحادثات
function initializeChatInputs() {
    // تهيئة جميع حقول الإدخال بعد تحميل الصفحة
    setTimeout(() => {
        const aiChatInputs = document.querySelectorAll('.assistant-chat .chat-input input, .supplies-chat .chat-input input');
        aiChatInputs.forEach(input => {
            // إزالة المستمع القديم إن وجد
            const newInput = input.cloneNode(true);
            input.parentNode.replaceChild(newInput, input);
            
            newInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' && this.value.trim()) {
                    const chatElement = this.closest('.assistant-chat, .supplies-chat');
                    if (chatElement) {
                        sendAIMessage(this.value.trim(), chatElement);
                        this.value = '';
                    }
                }
            });
        });
    }, 500);
}

// إعادة تهيئة عند فتح كارد الخدمات
function toggleServiceCard(cardId) {
    const cardContent = document.getElementById(cardId);
    const allContents = document.querySelectorAll('.service-content');
    const allCards = document.querySelectorAll('.service-card');
    
    allContents.forEach(content => {
        if (content.id !== cardId) {
            content.classList.remove('active');
        }
    });
    
    allCards.forEach(card => {
        card.classList.remove('active');
    });
    
    if (cardContent.classList.contains('active')) {
        cardContent.classList.remove('active');
    } else {
        cardContent.classList.add('active');
        event.currentTarget.classList.add('active');
        
        // إعادة تهيئة حقول الإدخال عند فتح الكارد
        if (cardId === 'suppliesAssistant') {
            setTimeout(() => {
                initializeChatInputs();
            }, 100);
        }
        
        setTimeout(() => {
            cardContent.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }, 100);
    }
}

// إرسال رسالة لمساعد المستلزمات
function sendSuppliesMessage() {
    const input = document.getElementById('suppliesInput');
    const message = input.value.trim();
    
    if (!message) return;
    
    const messagesContainer = document.getElementById('suppliesChatMessages');
    
    // رسالة المستخدم
    const userMessage = document.createElement('div');
    userMessage.className = 'message user-message';
    userMessage.innerHTML = `<p>${message}</p>`;
    messagesContainer.appendChild(userMessage);
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
    
    input.value = '';
    
    // رد الذكاء الاصطناعي
    setTimeout(() => {
        const messageLower = message.toLowerCase();
        let aiReply = '';
        
        if (messageLower.includes('قفازات') || messageLower.includes('قفاز')) {
            aiReply = '🧤 <strong>قفازات طبية متوفرة:</strong><br><br>• قفازات لاتكس - صيدلية النور (2.5 كم)<br>• قفازات نيتريل - مركز الشفاء الطبي (3.8 كم)<br>• قفازات جراحية معقمة - صيدلية الأمل (1.2 كم)<br><br>هل تريد عنوان محدد؟';
        } else if (messageLower.includes('كمامات') || messageLower.includes('كمامة') || messageLower.includes('ماسك')) {
            aiReply = '😷 <strong>كمامات طبية:</strong><br><br>• كمامات N95 - صيدلية النور - 15 ريال/علبة<br>• كمامات جراحية 3 طبقات - مركز الشفاء - 8 ريال/علبة<br>• كمامات قماش - صيدلية الحياة - 12 ريال<br><br>جميعها متوفرة بكميات كبيرة.';
        } else if (messageLower.includes('حقن') || messageLower.includes('سرنجة') || messageLower.includes('إبر')) {
            aiReply = '💉 <strong>حقن وسرنجات:</strong><br><br>• سرنجات 5ml معقمة - صيدلية النور<br>• إبر حقن مختلفة المقاسات - مركز الشفاء<br>• سرنجات الأنسولين - صيدلية الأمل<br><br>متوفرة بكميات كبيرة.';
        } else if (messageLower.includes('ضماد') || messageLower.includes('شاش') || messageLower.includes('لاصق')) {
            aiReply = '🩹 <strong>ضمادات وشاش:</strong><br><br>• شاش طبي معقم - جميع الصيدليات<br>• ضمادات لاصقة - صيدلية النور<br>• شريط لاصق طبي - مركز الشفاء<br>• ضمادات مضادة للماء - صيدلية الحياة';
        } else if (messageLower.includes('معقم') || messageLower.includes('تعقيم') || messageLower.includes('كحول')) {
            aiReply = '🧴 <strong>معقمات ومطهرات:</strong><br><br>• معقم يدين (كحول 70%) - صيدلية النور - 12 ريال<br>• ديتول معقم للأسطح - مركز الشفاء - 18 ريال<br>• كحول طبي 95% - صيدلية الأمل - 8 ريال<br>• مناديل معقمة - جميع الصيدليات';
        } else if (messageLower.includes('جهاز ضغط') || messageLower.includes('قياس ضغط')) {
            aiReply = '🩺 <strong>أجهزة قياس ضغط الدم:</strong><br><br>• جهاز أومرون الرقمي - مركز الشفاء - 180 ريال<br>• جهاز بيورر الألماني - صيدلية النور - 220 ريال<br>• جهاز يدوي تقليدي - صيدلية الأمل - 85 ريال';
        } else if (messageLower.includes('سكر') || messageLower.includes('جلوكوز')) {
            aiReply = '🩸 <strong>أجهزة قياس السكر:</strong><br><br>• جهاز أكيوتشك - صيدلية النور - 120 ريال<br>• جهاز وان تاتش - مركز الشفاء - 95 ريال<br>• شرائط فحص السكر - من 40 ريال/علبة 50 شريط';
        } else if (messageLower.includes('حرارة') || messageLower.includes('ثرمومتر')) {
            aiReply = '🌡️ <strong>موازين الحرارة:</strong><br><br>• ثرمومتر رقمي سريع - 25 ريال<br>• ثرمومتر بالأشعة تحت الحمراء - 85 ريال<br>• ثرمومتر زئبقي - 15 ريال<br><br>متوفرة في صيدلية النور ومركز الشفاء.';
        } else if (messageLower.includes('شكرا') || messageLower.includes('شكراً')) {
            aiReply = '😊 العفو! سعيد بمساعدتك. إذا احتجت أي شيء آخر، أنا هنا!';
        } else {
            const generalReplies = [
                '🤖 يمكنني مساعدتك في العثور على أي مستلزمات طبية.<br><br>جرّب السؤال عن:<br>• قفازات<br>• كمامات<br>• حقن<br>• ضمادات<br>• معقمات<br>• أجهزة قياس',
                '📍 لدينا قاعدة بيانات شاملة بجميع الصيدليات القريبة.<br><br>ماذا تحتاج بالتحديد؟',
                '🔍 أخبرني عن المستلزمات التي تبحث عنها وسأجد لك أقرب الأماكن المتوفرة فيها مع الأسعار!',
                '💡 يمكنني مساعدتك في إيجاد أي مستلزمات طبية بالقرب منك. اسألني عن أي شيء!'
            ];
            aiReply = generalReplies[Math.floor(Math.random() * generalReplies.length)];
        }
        
        const aiMessage = document.createElement('div');
        aiMessage.className = 'message ai-message';
        aiMessage.innerHTML = `<p>${aiReply}</p>`;
        messagesContainer.appendChild(aiMessage);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }, 1000);
}

// معالجة Enter في مساعد المستلزمات
function handleSuppliesEnter(event) {
    if (event.key === 'Enter') {
        sendSuppliesMessage();
    }
}

// إرسال رسالة للذكاء الاصطناعي
function sendAIMessage(message, chatElement) {
    // هذه الدالة للمساعد الذكي العام فقط (ليس مساعد المستلزمات)
    const messagesContainer = chatElement.querySelector('.chat-messages');
    
    // رسالة المستخدم
    const userMessage = document.createElement('div');
    userMessage.className = 'message user-message';
    userMessage.innerHTML = `<p>${message}</p>`;
    messagesContainer.appendChild(userMessage);
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
    
    // رد الذكاء الاصطناعي
    setTimeout(() => {
        const aiReplies = [
            'شكراً على سؤالك. كيف يمكنني مساعدتك أكثر؟',
            'يمكنني تنظيم ملفات المرضى حسب الأولوية والحالة.',
            'سأقوم بإنشاء تقرير طبي مفصل بناءً على المعلومات المتوفرة.',
            'أقترح عليك مراجعة السجلات الطبية للمريض قبل الموعد القادم.',
            'هل تريد مني مساعدتك في شيء محدد؟'
        ];
        
        const aiMessage = document.createElement('div');
        aiMessage.className = 'message ai-message';
        aiMessage.innerHTML = `<p>${aiReplies[Math.floor(Math.random() * aiReplies.length)]}</p>`;
        messagesContainer.appendChild(aiMessage);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }, 1000);
}

// معالجة أزرار إرسال الرسائل
document.addEventListener('click', function(e) {
    // زر إرسال في المحادثات الذكية
    if (e.target.closest('.chat-input button:not(.confirm-btn):not(.scan-btn):not(.view-file-btn):not(.view-records-btn):not(.generate-report-btn):not(.view-lab-results-btn)')) {
        const button = e.target.closest('button');
        const chatInput = button.closest('.chat-input');
        if (chatInput) {
            const input = chatInput.querySelector('input');
            if (input && input.value.trim()) {
                const chatElement = button.closest('.assistant-chat, .supplies-chat');
                if (chatElement) {
                    sendAIMessage(input.value.trim(), chatElement);
                    input.value = '';
                }
            }
        }
    }
});

// معالجة تأكيد المواعيد
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('confirm-btn')) {
        const bookingItem = e.target.closest('.booking-item');
        const dateInput = bookingItem.querySelector('.booking-date');
        const timeInput = bookingItem.querySelector('.booking-time');
        
        if (dateInput.value && timeInput.value) {
            e.target.textContent = '✓ تم التأكيد';
            e.target.style.background = '#50C878';
            e.target.disabled = true;
            
            // إضافة تأثير النجاح
            bookingItem.style.background = 'rgba(80, 200, 120, 0.1)';
        }
    }
});

// معالجة زر عرض السجلات - تحديث لعرض السجل الكامل
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('view-records-btn')) {
        const patientName = e.target.closest('.archive-item').querySelector('h4').textContent;
        
        // تحديد معرف المريض بناءً على الاسم
        let patientId = 'p1'; // افتراضي
        if (patientName.includes('فاطمة')) patientId = 'p2';
        
        showMedicalRecord(patientId);
    }
});

// معالجة زر مسح QR
document.querySelectorAll('.scan-btn').forEach(button => {
    button.addEventListener('click', function() {
        // محاكاة فتح الكاميرا
        this.textContent = 'جاري المسح...';
        this.disabled = true;
        
        setTimeout(() => {
            const scannerArea = this.closest('.qr-scanner, .lab-scanner');
            if (scannerArea) {
                const scannedResult = scannerArea.querySelector('.scanned-result');
                if (scannedResult) {
                    scannerArea.querySelector('.scanner-area').style.display = 'none';
                    scannedResult.style.display = 'block';
                }
            }
        }, 2000);
    });
});

// معالجة زر عرض نتائج التحاليل
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('view-lab-results-btn')) {
        showLabResults();
    }
});

// عرض نتائج التحاليل
function showLabResults() {
    const data = labResultsData;
    
    const modalHTML = `
        <div class="medical-record-modal active" id="labResultsModal" onclick="closeModalOnBackdrop(event)">
            <div class="medical-record-content" onclick="event.stopPropagation()">
                <div class="medical-record-header">
                    <h2>نتائج التحاليل الطبية</h2>
                    <button class="close-modal-btn" onclick="closeLabResultsModal()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="medical-record-body">
                    <div class="patient-header-info" style="background: linear-gradient(135deg, #4A90E2, #50C878); color: white; padding: 1.5rem; border-radius: 15px; margin-bottom: 2rem;">
                        <div style="text-align: center;">
                            <h3 style="color: white; font-size: 1.5rem; margin-bottom: 0.5rem;">${data.patientName}</h3>
                            <p style="color: rgba(255,255,255,0.9);"><strong>رقم المريض:</strong> ${data.patientId}</p>
                            <p style="color: rgba(255,255,255,0.9);"><strong>تاريخ التحليل:</strong> ${data.testDate}</p>
                            <p style="color: rgba(255,255,255,0.9);"><strong>المختبر:</strong> ${data.labName}</p>
                        </div>
                    </div>
                    
                    ${data.tests.map(category => `
                        <div class="record-section">
                            <h3><i class="fas fa-flask"></i> ${category.category}</h3>
                            <div style="overflow-x: auto;">
                                <table style="width: 100%; border-collapse: collapse; margin-top: 1rem;">
                                    <thead>
                                        <tr style="background: #f8f9fa;">
                                            <th style="padding: 1rem; text-align: right; border: 1px solid #e5e7eb;">الفحص</th>
                                            <th style="padding: 1rem; text-align: center; border: 1px solid #e5e7eb;">النتيجة</th>
                                            <th style="padding: 1rem; text-align: center; border: 1px solid #e5e7eb;">الوحدة</th>
                                            <th style="padding: 1rem; text-align: center; border: 1px solid #e5e7eb;">المعدل الطبيعي</th>
                                            <th style="padding: 1rem; text-align: center; border: 1px solid #e5e7eb;">الحالة</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        ${category.results.map(test => `
                                            <tr>
                                                <td style="padding: 0.8rem; border: 1px solid #e5e7eb;">${test.name}</td>
                                                <td style="padding: 0.8rem; text-align: center; border: 1px solid #e5e7eb; font-weight: 600;">${test.value}</td>
                                                <td style="padding: 0.8rem; text-align: center; border: 1px solid #e5e7eb;">${test.unit}</td>
                                                <td style="padding: 0.8rem; text-align: center; border: 1px solid #e5e7eb; color: #6B7280;">${test.range}</td>
                                                <td style="padding: 0.8rem; text-align: center; border: 1px solid #e5e7eb;">
                                                    <span style="display: inline-block; padding: 0.3rem 0.8rem; background: ${test.status === 'normal' ? '#50C878' : '#FF6B6B'}; color: white; border-radius: 15px; font-size: 0.85rem;">
                                                        ${test.status === 'normal' ? '✓ طبيعي' : '⚠ غير طبيعي'}
                                                    </span>
                                                </td>
                                            </tr>
                                        `).join('')}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    `).join('')}
                    
                    <div class="record-section" style="background: #f0f9ff; padding: 1.5rem; border-radius: 15px; border-right: 4px solid #4A90E2;">
                        <h3 style="color: #4A90E2; margin-bottom: 1rem;"><i class="fas fa-notes-medical"></i> ملاحظات الطبيب</h3>
                        <p style="color: #1F2937; line-height: 1.8;">
                            نتائج التحاليل تظهر أن جميع القيم ضمن المعدل الطبيعي. يُنصح بالاستمرار على نفس النظام الغذائي والدوائي الحالي. 
                            المتابعة الدورية بعد 3 أشهر للتأكد من استقرار الحالة الصحية.
                        </p>
                        <div style="margin-top: 1rem; padding: 1rem; background: white; border-radius: 10px;">
                            <p style="color: #6B7280; font-size: 0.9rem;">
                                <i class="fas fa-user-md"></i> د. أحمد السعيدي - أخصائي طب عام
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // إزالة أي modal موجود
    const existingModal = document.getElementById('labResultsModal');
    if (existingModal) {
        existingModal.remove();
    }
    
    document.body.insertAdjacentHTML('beforeend', modalHTML);
}

// إغلاق نافذة نتائج التحاليل
function closeLabResultsModal() {
    const modal = document.getElementById('labResultsModal');
    if (modal) {
        modal.classList.remove('active');
        setTimeout(() => modal.remove(), 300);
    }
}

// معالجة زر عرض الملف الطبي من QR
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('view-file-btn')) {
        showMedicalRecord('p1');
    }
});

// معالجة زر توليد التقرير
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('generate-report-btn')) {
        const form = e.target.closest('.report-form');
        const patient = form.querySelector('select').value;
        const notes = form.querySelector('textarea').value;
        
        if (patient && notes.trim()) {
            e.target.textContent = 'جاري التوليد...';
            e.target.disabled = true;
            
            setTimeout(() => {
                // إنشاء تقرير وهمي
                const reportHTML = `
                    <div style="margin-top: 2rem; padding: 2rem; background: #f8f9fa; border-radius: 15px; border: 2px solid #50C878;">
                        <h3 style="color: #50C878; margin-bottom: 1rem;"><i class="fas fa-check-circle"></i> تم توليد التقرير بنجاح!</h3>
                        <div style="background: white; padding: 1.5rem; border-radius: 10px; margin-top: 1rem;">
                            <h4 style="color: #4A90E2;">التقرير الطبي - ${patient}</h4>
                            <p style="margin: 1rem 0;"><strong>التاريخ:</strong> ${new Date().toLocaleDateString('ar-SA')}</p>
                            <p style="margin: 1rem 0;"><strong>ملاحظات الطبيب:</strong></p>
                            <p style="background: #f8f9fa; padding: 1rem; border-radius: 8px;">${notes}</p>
                            <p style="margin: 1rem 0;"><strong>التوصيات:</strong></p>
                            <p style="background: #f8f9fa; padding: 1rem; border-radius: 8px;">
                                - المتابعة الدورية كل أسبوعين<br>
                                - الالتزام بالأدوية الموصوفة<br>
                                - تجنب الإجهاد البدني الشديد<br>
                                - تناول غذاء صحي ومتوازن
                            </p>
                        </div>
                        <button style="margin-top: 1rem; padding: 0.8rem 2rem; background: #4A90E2; color: white; border: none; border-radius: 10px; cursor: pointer;" onclick="this.parentElement.remove()">
                            <i class="fas fa-download"></i> تحميل التقرير
                        </button>
                    </div>
                `;
                
                form.insertAdjacentHTML('afterend', reportHTML);
                e.target.textContent = 'توليد تقرير جديد';
                e.target.disabled = false;
                form.querySelector('textarea').value = '';
            }, 2000);
        }
    }
});

// إغلاق التنبيهات عند النقر خارجها
document.addEventListener('click', function(e) {
    const notificationsPanel = document.getElementById('notificationsPanel');
    const notificationBtn = document.querySelector('.notification-btn');
    
    if (notificationsPanel && notificationsPanel.classList.contains('active')) {
        if (!notificationsPanel.contains(e.target) && !notificationBtn.contains(e.target)) {
            notificationsPanel.classList.remove('active');
        }
    }
});

// تهيئة الحركات عند تحميل الصفحة
window.addEventListener('load', function() {
    const cards = document.querySelectorAll('.main-card, .ai-card, .message-card, .service-card');
    
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'all 0.5s ease';
        
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, index * 100);
    });
});

console.log('تم تحميل التطبيق بنجاح! 🎉');
console.log('جميع الميزات التفاعلية جاهزة للاستخدام');

// ==================== وظائف الإعدادات ====================

// بيانات المرضى
const patientsData = [
    { id: 1, name: 'سارة أحمد', age: 28, lastVisit: '2024-02-10', condition: 'متابعة دورية', avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%23FF6B9D\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eس%3C/text%3E%3C/svg%3E' },
    { id: 2, name: 'محمد علي', age: 45, lastVisit: '2024-02-08', condition: 'علاج ضغط الدم', avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%234A90E2\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eم%3C/text%3E%3C/svg%3E' },
    { id: 3, name: 'فاطمة حسن', age: 35, lastVisit: '2024-02-05', condition: 'فحص شامل', avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%2350E3C2\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eف%3C/text%3E%3C/svg%3E' },
    { id: 4, name: 'عبدالله محمود', age: 52, lastVisit: '2024-02-03', condition: 'مراجعة تحاليل', avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%23FFA500\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eع%3C/text%3E%3C/svg%3E' },
    { id: 5, name: 'ليلى عثمان', age: 31, lastVisit: '2024-01-28', condition: 'استشارة طبية', avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%239B59B6\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eل%3C/text%3E%3C/svg%3E' },
    { id: 6, name: 'خالد يوسف', age: 39, lastVisit: '2024-01-25', condition: 'علاج مزمن', avatar: 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'50\' height=\'50\'%3E%3Ccircle cx=\'25\' cy=\'25\' r=\'25\' fill=\'%23E74C3C\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-size=\'20\' font-family=\'Arial\'%3Eخ%3C/text%3E%3C/svg%3E' }
];

// فتح نافذة تعديل الملف الشخصي
function openEditProfile() {
    document.getElementById('editProfileModal').classList.add('active');
}

// فتح نافذة تغيير كلمة المرور
function openChangePassword() {
    document.getElementById('changePasswordModal').classList.add('active');
}

// فتح نافذة مرضاي
function openMyPatients() {
    document.getElementById('myPatientsModal').classList.add('active');
    loadPatients();
}

// إغلاق النوافذ
function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('active');
}

// حفظ الملف الشخصي
function saveProfile() {
    alert('✅ تم حفظ التغييرات بنجاح!');
    closeModal('editProfileModal');
}

// تغيير كلمة المرور
function changePassword() {
    alert('✅ تم تغيير كلمة المرور بنجاح!');
    closeModal('changePasswordModal');
}

// تحميل قائمة المرضى
function loadPatients() {
    const list = document.getElementById('patientsList');
    list.innerHTML = patientsData.map(p => `
        <div class="patient-item">
            <img src="${p.avatar}" alt="${p.name}">
            <div class="patient-info">
                <h4>${p.name}</h4>
                <p>العمر: ${p.age} • آخر زيارة: ${p.lastVisit}</p>
                <p style="color: var(--primary-blue); margin-top: 0.2rem; font-size: 0.85rem;">${p.condition}</p>
            </div>
            <div class="patient-actions">
                <button class="action-btn edit" onclick="editPatient(${p.id})"><i class="fas fa-edit"></i></button>
                <button class="action-btn delete" onclick="deletePatient(${p.id})"><i class="fas fa-trash"></i></button>
            </div>
        </div>
    `).join('');
}

// البحث في المرضى
function searchPatients(query) {
    const filtered = patientsData.filter(p => 
        p.name.toLowerCase().includes(query.toLowerCase()) ||
        p.condition.toLowerCase().includes(query.toLowerCase())
    );
    
    const list = document.getElementById('patientsList');
    if (filtered.length === 0) {
        list.innerHTML = '<p style="text-align: center; padding: 2rem; color: var(--gray);">لا توجد نتائج</p>';
    } else {
        list.innerHTML = filtered.map(p => `
            <div class="patient-item">
                <img src="${p.avatar}" alt="${p.name}">
                <div class="patient-info">
                    <h4>${p.name}</h4>
                    <p>العمر: ${p.age} • آخر زيارة: ${p.lastVisit}</p>
                    <p style="color: var(--primary-blue); margin-top: 0.2rem; font-size: 0.85rem;">${p.condition}</p>
                </div>
                <div class="patient-actions">
                    <button class="action-btn edit" onclick="editPatient(${p.id})"><i class="fas fa-edit"></i></button>
                    <button class="action-btn delete" onclick="deletePatient(${p.id})"><i class="fas fa-trash"></i></button>
                </div>
            </div>
        `).join('');
    }
}

// تعديل مريض
function editPatient(id) {
    const patient = patientsData.find(p => p.id === id);
    alert(`تعديل بيانات: ${patient.name}`);
}

// حذف مريض
function deletePatient(id) {
    const patient = patientsData.find(p => p.id === id);
    if (confirm(`هل أنت متأكد من حذف: ${patient.name}؟`)) {
        const index = patientsData.findIndex(p => p.id === id);
        patientsData.splice(index, 1);
        loadPatients();
        alert('✅ تم الحذف بنجاح!');
    }
}

// تسجيل الخروج
function logout() {
    if (confirm('هل أنت متأكد من تسجيل الخروج؟')) {
        alert('تم تسجيل الخروج بنجاح!');
        setTimeout(() => window.location.reload(), 1000);
    }
}

/* ================================================================
   BOOKING SYSTEM — نظام إدارة الحجوزات للطبيب
   ================================================================ */

/**
 * تحميل قائمة الحجوزات المعلقة وعرضها
 */
function loadAppointments() {
  var container = document.getElementById("appointmentsContainer");
  if (!container) return;

  container.innerHTML = '<p style="text-align:center;color:#888;">جاري التحميل...</p>';

  fetch("get_appointments.php?status=pending")
    .then(function(res) { return res.json(); })
    .then(function(data) {
      if (!Array.isArray(data) || data.length === 0) {
        container.innerHTML = '<p style="text-align:center;color:#888;padding:20px;">لا توجد حجوزات معلقة حالياً</p>';
        return;
      }

      var html = "";
      data.forEach(function(app) {
        var caseLabel = app.case_type ? app.case_type : '—';
        var caseBadge = '';
        if (app.case_type === 'مستعجلة') caseBadge = 'style="color:#dc2626;font-weight:bold;"';
        else if (app.case_type === 'مزمنة') caseBadge = 'style="color:#f59e0b;font-weight:bold;"';

        var createdDate = app.created_at ? app.created_at.substring(0, 16) : '—';

        html += `
          <div class="appointment-card" id="appt_card_${app.id}">
            <div class="booking-patient">
              <i class="fas fa-user-circle" style="font-size:28px;color:#3b82f6;margin-left:10px;"></i>
              <div>
                <h4 style="margin:0 0 2px;">${escapeHtml(app.patient_name)}</h4>
                <p style="margin:0;font-size:13px;color:#555;">${escapeHtml(app.phone)}</p>
                <p style="margin:2px 0 0;" ${caseBadge}>نوع الحالة: ${escapeHtml(caseLabel)}</p>
                <p style="margin:2px 0 0;font-size:12px;color:#999;">طُلب في: ${createdDate}</p>
              </div>
            </div>

            <div class="booking-datetime" style="margin:10px 0;">
              <label style="font-size:13px;color:#555;">تاريخ الموعد:</label>
              <input type="date" id="appt_date_${app.id}" style="margin:4px 6px;">
              <label style="font-size:13px;color:#555;">الساعة:</label>
              <input type="time" id="appt_time_${app.id}" style="margin:4px 6px;">
            </div>

            <div style="display:flex;gap:8px;flex-wrap:wrap;">
              <button
                onclick="confirmAppointment(${app.id})"
                style="background:#16a34a;color:#fff;border:none;padding:8px 18px;border-radius:8px;cursor:pointer;font-size:14px;">
                ✅ قبول وتأكيد
              </button>
              <button
                onclick="rejectAppointment(${app.id})"
                style="background:#dc2626;color:#fff;border:none;padding:8px 18px;border-radius:8px;cursor:pointer;font-size:14px;">
                ❌ رفض
              </button>
            </div>
          </div>
        `;
      });

      container.innerHTML = html;
    })
    .catch(function() {
      container.innerHTML = '<p style="color:#dc2626;text-align:center;">خطأ في تحميل الحجوزات</p>';
    });
}

/**
 * helper: escape HTML لمنع XSS
 */
function escapeHtml(str) {
  if (!str) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

/**
 * قبول الموعد وتحديد التاريخ والوقت
 */
function confirmAppointment(id) {
  // FIX: البحث عن inputs بالـ ID الصحيح (appt_date_X) أو القديم (dateX) للتوافق مع PHP-rendered cards
  var dateInput = document.getElementById("appt_date_" + id) || document.getElementById("date" + id);
  var timeInput = document.getElementById("appt_time_" + id) || document.getElementById("time" + id);

  if (!dateInput || !timeInput) {
    alert("❌ خطأ: لم يُعثر على حقول التاريخ/الوقت، يرجى تحديث الصفحة.");
    return;
  }

  var date = (dateInput.value || "").trim();
  var time = (timeInput.value || "").trim();

  // FIX: رسائل validation واضحة
  if (!date) {
    alert("⚠️ يرجى تحديد تاريخ الموعد قبل التأكيد.");
    dateInput.focus();
    return;
  }
  if (!time) {
    alert("⚠️ يرجى تحديد ساعة الموعد قبل التأكيد.");
    timeInput.focus();
    return;
  }

  fetch("accept_appointment.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id: id, action: "confirm", date: date, time: time })
  })
  .then(function(res) {
    if (!res.ok) throw new Error("HTTP " + res.status);
    return res.json();
  })
  .then(function(data) {
    if (data.success) {
      var card = document.getElementById("appt_card_" + id);
      // FIX: البحث أيضاً في booking-item (PHP-rendered cards)
      if (!card) {
        var items = document.querySelectorAll(".booking-item");
        items.forEach(function(item) {
          if (item.querySelector("#appt_date_" + id) || item.querySelector("#date" + id)) {
            card = item;
          }
        });
      }
      if (card) {
        card.style.opacity = "0.4";
        card.innerHTML = '<p style="text-align:center;padding:12px;color:#16a34a;">✅ تم تأكيد الموعد وإرسال إشعار للمريض</p>';
        setTimeout(function() { loadAppointments(); }, 1500);
      } else {
        loadAppointments();
      }
    } else {
      alert(data.message || "حدث خطأ في التأكيد");
    }
  })
  .catch(function(err) {
    console.error("confirmAppointment error:", err);
    alert("❌ خطأ في الاتصال بالخادم، حاول مرة أخرى.");
  });
}

/**
 * رفض طلب الموعد
 */
function rejectAppointment(id) {
  if (!confirm("هل أنت متأكد من رفض هذا الطلب؟")) return;

  fetch("accept_appointment.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id: id, action: "reject" })
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) {
      var card = document.getElementById("appt_card_" + id);
      if (card) {
        card.style.opacity = "0.4";
        card.innerHTML = '<p style="text-align:center;padding:12px;color:#dc2626;">❌ تم رفض الطلب وإرسال إشعار للمريض</p>';
        setTimeout(function() { loadAppointments(); }, 1500);
      } else {
        loadAppointments();
      }
    } else {
      alert(data.message || "حدث خطأ");
    }
  })
  .catch(function() { alert("خطأ في الاتصال بالخادم"); });
}

// تحميل الحجوزات عند فتح الصفحة
loadAppointments();
function markCompleted(id) {
    fetch("update_appointment_status.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `id=${id}&status=completed`
    })
    .then(res => res.text())
    .then(() => location.reload());
}

function markNoShow(id) {
    fetch("update_appointment_status.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `id=${id}&status=no_show`
    })
    .then(res => res.text())
    .then(() => location.reload());
}
function openRescheduleModal(id) {
    document.getElementById("reschedule_id").value = id;
    document.getElementById("reschedule_date").value = "";
    document.getElementById("reschedule_time").value = "";
    document.getElementById("rescheduleModal").style.display = "flex";
}

function closeRescheduleModal() {
    document.getElementById("rescheduleModal").style.display = "none";
}

function saveReschedule() {
    const id = document.getElementById("reschedule_id").value;
    const date = document.getElementById("reschedule_date").value;
    const time = document.getElementById("reschedule_time").value;

    if (!date || !time) {
        alert("اختر التاريخ والوقت");
        return;
    }

    fetch("reschedule_appointment.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `id=${id}&date=${date}&time=${time}`
    })
    .then(res => res.text())
    .then(() => location.reload());
}
function openPatientFile(patientId){
    document.getElementById("patientFileModal").style.display = "flex";
}

function closePatientFile(){
    document.getElementById("patientFileModal").style.display = "none";
}
function saveMedicalRecord() {



const data = new FormData();

let patientId = document.getElementById("medical_patient_id");
data.append("patient_id", patientId ? patientId.value : "");
data.append("full_name", document.getElementById("full_name").value);
data.append("birth_info", document.getElementById("birth_info").value);
data.append("marital_status", document.getElementById("marital_status").value);
data.append("job", document.getElementById("job").value);
data.append("address", document.getElementById("address").value);
data.append("phone", document.getElementById("phone").value);

data.append("reason_exam", document.getElementById("reason_exam").value);
data.append("symptoms", document.getElementById("symptoms").value);

data.append("blood_pressure", document.getElementById("blood_pressure").value);
data.append("blood_sugar", document.getElementById("blood_sugar").value);
data.append("heart_rate", document.getElementById("heart_rate").value);
data.append("temperature", document.getElementById("temperature").value);
data.append("oxygen_level", document.getElementById("oxygen_level").value);

data.append("chronic_patient", document.getElementById("chronic_patient").value);
data.append("chronic_family", document.getElementById("chronic_family").value);

data.append("medical_tests", document.getElementById("medical_tests").value);
data.append("radiology", document.getElementById("radiology").value);

data.append("prescription", document.getElementById("prescription").value);

data.append("needs_appointment", document.getElementById("needs_appointment").value);
data.append("next_appointment_date", document.getElementById("next_appointment_date").value);
data.append("next_appointment_time", document.getElementById("next_appointment_time").value);
const getVal = (id) => {
    const el = document.getElementById(id);
    return el ? el.value : "";
};

data.append("last_period_date", getVal("last_period_date"));
data.append("expected_delivery_date", getVal("expected_delivery_date"));
data.append("preg_blood_type", getVal("preg_blood_type"));
data.append("pregnancies_count", getVal("pregnancies_count"));
data.append("births_count", getVal("births_count"));
data.append("miscarriages_count", getVal("miscarriages_count"));
data.append("c_sections_count", getVal("c_sections_count"));
data.append("preg_chronic_diseases", getVal("preg_chronic_diseases"));
data.append("father_status", getVal("father_status"));
data.append("consanguinity", getVal("consanguinity"));
data.append("pregnancy_notes", getVal("pregnancy_notes"));

data.append("preg_weight", getVal("preg_weight"));
data.append("preg_blood_pressure", getVal("preg_blood_pressure"));
data.append("preg_sugar_level", getVal("preg_sugar_level"));
data.append("fetal_heartbeat", getVal("fetal_heartbeat"));
data.append("fetal_movement", getVal("fetal_movement"));
data.append("fetal_weight", getVal("fetal_weight"));
data.append("fetal_position", getVal("fetal_position"));
data.append("echo_notes", getVal("echo_notes"));
data.append("followup_notes", getVal("followup_notes"));
    fetch("save_doctor_record.php", {
        method: "POST",
        body: data
    })
    .then(res => res.text())
    .then(msg => {
        alert("تم حفظ الملف الطبي بنجاح ✅");
        closePatientFile();
    });
}
function nextStep(step){
    document.querySelectorAll(".medical-step").forEach(el=>{
        el.classList.remove("active-step");
    });

    document.getElementById("step"+step).classList.add("active-step");
}

function prevStep(step){
    document.querySelectorAll(".medical-step").forEach(el=>{
        el.classList.remove("active-step");
    });

    document.getElementById("step"+step).classList.add("active-step");
}

document.addEventListener("change", function(e){
    if(e.target.id === "needs_appointment"){
        const box = document.getElementById("appointmentFields");

        if(e.target.value === "yes"){
            box.style.display = "block";
        }else{
            box.style.display = "none";
        }
    }
});
function printPrescription() {
    const patientName = document.getElementById("rx_patient_name").value;
    const rxDate = document.getElementById("rx_date").value;
    const medicines = document.getElementById("prescription").value;
    const notes = document.getElementById("doctor_notes").value;
    const signature = document.getElementById("doctor_signature").value;

    const doctorName =
        document.querySelector(".doctor-box h2")?.innerText || "";
    const specialty =
        document.querySelector(".doctor-box p:nth-of-type(1)")?.innerText || "";
    const license =
        document.querySelector(".doctor-box p:nth-of-type(2)")?.innerText || "";
    const address =
        document.querySelector(".doctor-box p:nth-of-type(3)")?.innerText || "";

    const win = window.open("", "_blank");

    win.document.write(`
        <html>
        <head>
            <title>Prescription</title>
            <style>
                body{
                    font-family:Arial,sans-serif;
                    background:white;
                    margin:0;
                    padding:40px;
                    direction:rtl;
                }

                .paper{
                    max-width:900px;
                    margin:auto;
                    line-height:2;
                }

                .top{
                    display:flex;
                    justify-content:space-between;
                    margin-bottom:30px;
                }

                .doctor{
                    width:50%;
                }

                .doctor h2{
                    color:#0d47a1;
                    margin:0;
                }

                .patient{
                    width:35%;
                }

                .title{
                    text-align:center;
                    font-size:42px;
                    color:#0d47a1;
                    margin:30px 0;
                    letter-spacing:4px;
                    font-weight:bold;
                }

                .content{
                    min-height:250px;
                    white-space:pre-wrap;
                    font-size:20px;
                }

                .notes{
                    margin-top:30px;
                    white-space:pre-wrap;
                }

                .sign{
                    margin-top:70px;
                    text-align:left;
                    font-weight:bold;
                    font-size:22px;
                }

                hr{
                    margin:25px 0;
                }
            </style>
        </head>
        <body>
            <div class="paper">

                <div class="top">
                    <div class="doctor">
                        <h2>${doctorName}</h2>
                        <div>${specialty}</div>
                        <div>${license}</div>
                        <div>${address}</div>
                    </div>

                    <div class="patient">
                        <div><b>اسم المريض:</b> ${patientName}</div>
                        <br>
                        <div><b>التاريخ:</b> ${rxDate}</div>
                    </div>
                </div>

                <hr>

                <div class="title">ORDONNANCE</div>

                <div class="content">${medicines}</div>

                <div class="notes">${notes}</div>

                <div class="sign">${signature}</div>

            </div>
        </body>
        </html>
    `);

    win.document.close();
    win.focus();
    win.print();
}
function printMedicalRecord() {
    const modal = document.querySelector(".patient-modal-content").cloneNode(true);

    // نعمر القيم المكتوبة
    modal.querySelectorAll("input, textarea, select").forEach(el => {
        if (el.tagName === "TEXTAREA") {
            el.innerHTML = el.value;
        } else {
            el.setAttribute("value", el.value);
        }
    });

    const content = modal.innerHTML;

    const win = window.open("", "", "width=1000,height=800");

    win.document.write(`
        <html>
        <head>
            <title>Medical Record</title>
            <style>
                body{
                    font-family:Arial;
                    padding:35px;
                    line-height:1.8;
                }

                input, textarea, select{
                    width:100%;
                    padding:10px;
                    border:1px solid #ccc;
                    border-radius:8px;
                    margin-top:6px;
                    margin-bottom:14px;
                }

                h2,h3{
                    color:#0f766e;
                }

                button, .close-patient-modal{
                    display:none;
                }
            </style>
        </head>
        <body>
            ${content}
        </body>
        </html>
    `);

    win.document.close();
    win.print();
}
function savePrescription() {
    const getVal = (id) => {
        const el = document.getElementById(id);
        return el ? el.value : "";
    };

    const data = new FormData();
    data.append("patient_id", getVal("medical_patient_id"));
    data.append("patient_name", getVal("rx_patient_name"));
    data.append("rx_date", getVal("rx_date"));
    data.append("medicines", getVal("prescription"));
    data.append("notes", getVal("doctor_notes"));
    data.append("signature", getVal("doctor_signature"));

    fetch("save_prescription.php", {
        method: "POST",
        body: data
    })
    .then(res => res.text())
    .then(msg => {
        console.log(msg);
        alert(msg);
    })
    .catch(err => console.error(err));
}