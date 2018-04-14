// Part 2 Data Visualization Initializations/ Global Vars
color c;
Table cancerDataTable;
StringList cancerSite = new StringList();
StringList incidenceAssumption = new StringList();
IntList year = new IntList();
IntList totalCosts = new IntList();
IntList initYearCost = new IntList();
IntList contCost = new IntList();
IntList lastCost = new IntList();
ArrayList<dataVis> dataVisArrayList = new ArrayList<dataVis>();
color[] colorArray = {#e6194b, #3cb44b, #ffe119, #0082c8, #f58231, #911eb4, #46f0f0, #f032e6, #d2f53c, #fabebe, #008080, #e6beff, #aa6e28, #fffac8, #800000, #aaffc3, #808000, #ffd8b1, #000080, #808080, #FFFFFF, #000000};

void setup() {
  size(500, 500);
  
  // Part 2 Data Visualization Setup
  cancerDataTable = loadTable("cancerExpenditureData.csv", "header");
  //println(cancerDataTable.getRowCount());
  for (TableRow row : cancerDataTable.rows()) {
    cancerSite.append(row.getString("cancer_site"));
    year.append(row.getInt("year"));
    incidenceAssumption.append(row.getString("incidence_and_survival_assumptions"));
    totalCosts.append(row.getInt("total_costs"));
    initYearCost.append(row.getInt("initial_year_after_diagnosis_cost"));
    contCost.append(row.getInt("continuing_phase_cost"));
    lastCost.append(row.getInt("last_year_of_life_cost"));
  }
  
  
  
}

void draw() {
  background(#000000);
  part2DataVis();
  for (dataVis dataObject : dataVisArrayList) {
    noStroke();
    dataObject.display();
    dataObject.update(mouseX, mouseY);
    if (dataObject.isMouseOver == true) {
      fill(#ffffff);
      textSize(30);
      String cancerName = ("Site: " + dataObject.cancerName);
      String initYearCost = ("Initial Cost: $" + dataObject.initYearCost + " Billion");
      String totalCost = ("Total Cost: $" + dataObject.cost + " Billion");
      text(cancerName, 75, 380);
      text(initYearCost, 75, 420);
      text(totalCost, 75, 460);
    }
  }
}

// Part 2 Data Vis Creation Function
void part2DataVis() {
  FloatList normalizedTotCost = new FloatList();
  FloatList normalizedInitCost = new FloatList();
  int totCostSum = 0;
  int avgTotCost = 0;
  for (int i : totalCosts) {
    totCostSum += i;
  }
  avgTotCost = totCostSum / totalCosts.size();
  
  int initCostSum = 0;
  int avgInitCost = 0;
  for (int i : initYearCost) {
    initCostSum += i;
  }
  avgInitCost = initCostSum / initYearCost.size();
  //print(avgInitCost);
  for (int i : totalCosts) {
    normalizedTotCost.append((i-avgTotCost)/100);
  } 
  
  for (int i : initYearCost) {
    normalizedInitCost.append((i - avgInitCost)/100);
  }
  
  float x = 15;
  for (int i = 0; i < totalCosts.size(); i++) {
    dataVis d;
    nameLookup(i);
    float y = 250 * (1+((-normalizedInitCost.get(i))/100));
    float r = 15 * (1+(normalizedTotCost.get(i)/100));
    String n = cancerSite.get(i);
    d = new dataVis(cancerSite.get(i), totalCosts.get(i), initYearCost.get(i), x, y, r, c, n);
    dataVisArrayList.add(d);
    x += ((width-5)/totalCosts.size());
  }
  
  configureYAxis();
    
}

void configureYAxis() {
  stroke(#FFFFFF);
  strokeWeight(4);
  line(5, 0, 5, 500);
  line(5, 150, 12, 150); 
  line(5, 300, 12, 300);
  textSize(15);
  fill(#FFFFFF);
  text("5300 Million", 15, 155); 
  text("700 Million", 15, 305);
  text("Costs are in billions USD; numbers are estimates from various", 15, 15);
  text("studies calculated across the United States.", 15, 32);
  text("Size of the circle represents total cost.", 15, 49);
  text("The Y-Axis represents initial year total treatment cost.", 15, 66);
  text("Types of cancer are differentiated by color.", 15, 83);
  strokeWeight(0);
}

void nameLookup(int i) {
  String currentSite = cancerSite.get(i);
  //println(currentSite);
  if (currentSite.equals("Bladder")) { c = colorArray[1]; }
  if (currentSite.equals("Stomach")) { c =  colorArray[2]; }
  if (currentSite.equals("Uterus")) { c =  colorArray[3]; }
  if (currentSite.equals("Other")) { c = colorArray[4]; }
  if (currentSite.equals("Brain")) { c =  colorArray[5]; }
  if (currentSite.equals("Colorectal")) { c =  colorArray[6]; }
  if (currentSite.equals("Esophagus")) { c =  colorArray[7]; }
  if (currentSite.equals("Head_Neck")) { c =  colorArray[8]; }
  if (currentSite.equals("Kidney")) { c =  colorArray[9]; }
  if (currentSite.equals("Leukemia")) { c =  colorArray[10]; }
  if (currentSite.equals("Lymphoma")) { c =  colorArray[11]; }
  if (currentSite.equals("Melanoma")) { c =  colorArray[12]; }
  if (currentSite.equals("Pancreas")) { c =  colorArray[13]; }
}
