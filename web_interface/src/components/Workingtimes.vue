<template>
  <div class="hello" ref="chartdiv"></div>
</template>

<script>
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";

am4core.useTheme(am4themes_animated);

export default {
  name: "Workingtimes",
  data () {
    return {
      workingtimes: "",
    }
  },
  mounted() {
    let chart = am4core.create(this.$refs.chartdiv, am4charts.XYChart); 

    chart.paddingRight = 40;

    let data = [
      {
        date: new Date("2019-09-26"),
        value: 3
      },
      {
        date: new Date("2019-09-27"),
        value: 10
      },
      {
        date: new Date("2019-09-28"),
        value: 5
      },
      {
        date: new Date("2019-09-29"),
        value: 10
      },
      {
        date: new Date("2019-09-30"),
        value: 3
      },
      {
        date: new Date("2019-10-01"),
        value: 5
      },
      {
        date: new Date("2019-10-02"),
        value: 8
      },
      {
        date: new Date("2019-10-03"),
        value: 3
      },
      {
        date: new Date("2019-10-04"),
        value: 10
      },
      {
        date: new Date("2019-10-05"),
        value: 5
      },
      {
        date: new Date("2019-10-06"),
        value: 10
      },
      {
        date: new Date("2019-10-07"),
        value: 3
      },
      {
        date: new Date("2019-10-08"),
        value: 5
      },
      {
        date: new Date("2019-10-09"),
        value: 8
      }
    ];
    /*for (let i = 0; i < data.length; i++) {
      data.push({ date: new Date(2019, 0, i), name: "name" + i, value: visits });
    }*/

    chart.dateFormatter.inputDateFormat = "YYYY-MM-dd"

    chart.data = data;

    let dateAxis = chart.xAxes.push(new am4charts.DateAxis());
    dateAxis.renderer.grid.template.location = 0;

    let valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
    valueAxis.tooltip.disabled = true;
    valueAxis.renderer.minWidth = 35;
    valueAxis.min = 0;
    valueAxis.max = 20;  

    let series = chart.series.push(new am4charts.ColumnSeries());
    series.dataFields.dateX = "date";
    series.dataFields.valueY = "value";

    series.tooltipText = "{valueY.value}";
    chart.cursor = new am4charts.XYCursor();

    let scrollbarX = new am4charts.XYChartScrollbar();
    scrollbarX.series.push(series);
    chart.scrollbarX = scrollbarX;

    this.chart = chart;
  },

  beforeDestroy() {
    if (this.chart) {
      this.chart.dispose();
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.hello {
  width: 100%;
  height: 500px;
}
</style>
