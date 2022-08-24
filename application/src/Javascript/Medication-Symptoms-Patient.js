
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
        ["Paracetamol", "Pain relief", "4h", "2 pills"],
        ["Ibuprofen", "Pain relief", "8h", "2 pills"]
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
        moreInfo.name = i[0];

        moreInfo.onclick = function (){
            alert(moreInfo.name + "\nFor: " + i[1] + ", take " + i[3] + " every " + i[2]);
        }
        let btntd = document.createElement('td');
        btntd.append(moreInfo);
        tr.append(btntd);
    }

}


function addMedication() {
    var table = document.getElementById("myTable");
    var row = table.insertRow(0);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    cell1.innerHTML = document.getElementById('cellOne').value;
    cell2.innerHTML = document.getElementById('cellTwo').value;
}


