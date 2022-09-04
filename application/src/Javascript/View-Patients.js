window.addEventListener("load", () => {
    /*This needs to be changed to read data from database once its setup */

    /*Currently uses hardcoded "patients" */
    var data = [
        {name : "Patient1", ID: "AB1234", Age:19, DOB: '10/9/2002', BloodGroup: "A", ethnicity: "English"},
        {name : "Patient2", ID: "BC1234", Age:19, DOB: '12/1/1992', BloodGroup: "B-", ethnicity: "English"},
        {name : "Patient3", ID: "DE1234", Age:19, DOB: '10/3/2012', BloodGroup: "A", ethnicity: "English"},
        {name : "Patient4", ID: "FG1234", Age:19, DOB: '27/1/1954', BloodGroup: "O-", ethnicity: "English"},
        {name : "Patient5", ID: "HI1234", Age:19, DOB: '18/3/2000', BloodGroup: "B+", ethnicity: "English"}
    ];

    // (B2) LOOP + ADD CELLS
    let container = document.getElementById("grid");
    /*Adds each patient to a seperate place in a grid*/
    for (let patient of data) {
            let cell = document.createElement("div");

        /*If more fields are added to the dictionary they need to be added here too so that the loop adds them to the grid*/
            cell.innerHTML ="Name: " + patient.name + "<br> ID: " + patient.ID + "<br> Age; " + patient.Age + "<br> DOB: " + patient.DOB
            + "<br> Blood Group: " + patient.BloodGroup + "<br>Ethnicity: " + patient.ethnicity + "<br>";
            cell.className = "cell"  ;
            let btn = document.createElement("button");
            btn.innerHTML = "View Patient";
            btn.onclick = visitPage.bind();
            cell.appendChild(btn);
            container.appendChild(cell);
    }

    /*Will send to given patient page when database is operation, for now will send to placeholder patient*/
    function visitPage(){
        window.location='Medication-Symptoms-Doctor.html'
    }

});
