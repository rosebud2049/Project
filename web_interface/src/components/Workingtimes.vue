<template>
  <div id="workingtime">
    <div class="hello" ref="chartdiv"></div>
    <div class="row">
      <div class="col-12 text-center">
        <button  type="button" class="btn btn-info btn-lg rounded-circle">
          <i class="fa fa-refresh" aria-hidden="true"></i>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
/*eslint-disable*/

import axios from "axios";
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";
import underscore from "underscore";

am4core.useTheme(am4themes_animated);

export default {
  name: "Workingtimes",
  data() {
    return {
      date: [],
      output: [],
      sum: [],
      workingtimes: [],
      temp_date: [],
      id: ""
    };
  },
  mounted() {
    this.id = JSON.parse(localStorage.getItem('user')).id

    axios
      .get("http://localhost:4002/api/workingtimes/" + this.id)
      .then(response => {
        response = response.data.data;
        this.workingtimes = [];
        this.sum = [];
        let data = [];

        for (let i = 0; i < response.length; i++) {
          let temp_date = response[i].end.split("T");
          let date = temp_date[0];
          let clockOut = new Date(response[i].end);
          let clockIn = new Date(response[i].start);
          let workingtime = (clockOut - clockIn) / 3600000;
          this.workingtimes[i] = { date: date, value: workingtime };
          this.temp_date.push(date);
        }

        this.output = this.workingtimes.reduce(function(o, cur) {
          // Get the index of the key-value pair.
          var occurs = o.reduce(function(n, item, i) {
            return item.date === cur.date ? i : n;
          }, -1);

          // If the name is found,
          if (occurs >= 0) {
            // append the current value to its list of values.
            o[occurs].value = o[occurs].value.concat(cur.value);

            // Otherwise,
          } else {
            // add the current item to o (but make sure the value is an array).
            var obj = {
              date: cur.date,
              value: [cur.value]
            };
            o = o.concat([obj]);
          }

          return o;
        }, []);

        for (let i = 0; i < this.output.length; i++) {
          let array_to_reduce = this.output[i].value;
          for (let j = 0; j < array_to_reduce.length; j++) {
            var valeurInitiale = 0;
            var somme = array_to_reduce.reduce((a, b) => a + b, 0);
          }
          this.sum.push(somme);
        }

        for (let k = 0; k < this.sum.length; k++) {
          this.output[k].value = this.sum[k];
        }

        for (let l = 0; l < this.output.length; l++) {
          data.push({ date: this.output[l].date, value: this.output[l].value });
        }

        let chart = am4core.create(this.$refs.chartdiv, am4charts.XYChart);

        chart.paddingRight = 40;

        chart.dateFormatter.inputDateFormat = "YYYY-MM-dd";

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
      })
      .catch(err => {
        console.log(err);
      });
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
