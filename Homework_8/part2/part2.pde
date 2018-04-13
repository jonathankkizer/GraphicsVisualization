// Part 2 Data Visualization Initializations/ Global Vars
Table cancerDataTable;
StringList cancerSite = new StringList();
StringList incidenceAssumption = new StringList();
IntList year = new IntList();
IntList totalCosts = new IntList();
IntList initYearCost = new IntList();
IntList contCost = new IntList();
IntList lastCost = new IntList();
ArrayList<dataVis> dataVisArrayList = new ArrayList<dataVis>();

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
  for (dataVis dataObject : dataVisArrayList) {
    dataObject.display();
  }
}

// triggers part 2 data vis
void keyPressed() {
  if (key == 'r') {
    part2DataVis();
  }
}

// Part 2 Data Vis Creation Function
void part2DataVis() {
  FloatList normalizedTotCost = new FloatList();
  int totCostSum = 0;
  int avgTotCost = 0;
  for (int i : totalCosts) {
    totCostSum += i;
  }
  avgTotCost = totCostSum / 84;
  
  for (int i : totalCosts) {
    normalizedTotCost.append((i-avgTotCost)/100);
  } 
  float x = 5;
  color c = #66CCCC;
  for (int i = 0; i < totalCosts.size(); i++) {
    dataVis d;
    float r = 15*(1+(normalizedTotCost.get(i)/100));
    d = new dataVis(x, r, c);
    dataVisArrayList.add(d);
    x += 15;
  }
  
    
}
