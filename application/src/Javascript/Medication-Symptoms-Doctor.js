
window.addEventListener("load", () => {

    createSymptoms();
    createMedication();
});
/*Creates rows from symptoms table, changing var symptoms to for loop for database should work*/
function createSymptoms() {
    var symptoms = [
        ["1", "Runny Nose", "3", "12/4/2022", "None", "None"],
        ["2", "Runny Nose", "5", "15/4/2022", "None", "None"]
    ];

    symptomTable = document.getElementById('symptoms');

    for (let i of symptoms) {
        const tr = symptomTable.insertRow();
        for (let j of i) {
            const td = tr.insertCell();
            td.appendChild(document.createTextNode(j));
            td.style.border = '1px solid black';
        }
    }

}

/*Creates rows from symptoms table, changing var medications to for loop for database should work*/
function createMedication(){
    var medications = [
        ["1", "Paracetamol", "Pain relief", "4h", "2 pills"],
        ["2", "Ibuprofen", "Pain relief", "8h", "2 pills"]
    ];
    medicationTable = document.getElementById('medication');

    for (let i of medications) {
        const tr = medicationTable.insertRow();
        for (let j of i) {
            const td = tr.insertCell();
            td.appendChild(document.createTextNode(j));
            td.style.border = '1px solid black';
        }
        let moreInfo = document.createElement("button");
        moreInfo.innerHTML = "More Info";
        moreInfo.name = i[1];

        moreInfo.onclick = function (){
            alert(moreInfo.name + "\nFor: " + i[2] + ", take " + i[4] + " every " + i[3]);
        }
        let btntd = document.createElement('td');
        btntd.append(moreInfo);
        tr.append(btntd);
    }

}



