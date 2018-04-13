// Data sourced from here: https://data.world/health/expenditures-for-cancer-care
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
  print(avgInitCost);
  for (int i : totalCosts) {
    normalizedTotCost.append((i-avgTotCost)/100);
  } 
  
  for (int i : initYearCost) {
    normalizedInitCost.append((i - avgInitCost)/100);
  }
  
  float x = 15;
  color c = #66CCCC;
  for (int i = 0; i < totalCosts.size(); i++) {
    dataVis d;
    float y = 250 * (1+((-normalizedInitCost.get(i))/100));
    float r = 15 * (1+(normalizedTotCost.get(i)/100));
    String n = cancerSite.get(i);
    d = new dataVis(x, y, r, c, n);
    dataVisArrayList.add(d);
    x += ((width-5)/totalCosts.size());
  }
  
    
}
