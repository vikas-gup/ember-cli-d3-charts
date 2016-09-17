`import Ember from 'ember'`

barChartComponent = Ember.Component.extend
	didInsertElement: ->
		@plotGraph()

	plotGraph: ->
		margin =
			top: 20
			right: 20
			bottom: 70
			left: 80

		width = @get('width')
		height = @get('height')
		width = width - (margin.left) - (margin.right)
		height = height - (margin.top) - (margin.bottom)

		x = d3.scaleBand().rangeRound([0, width]).padding(0.1)
		y = d3.scaleLinear().rangeRound([height, 0])

		svg = d3.select(@get('className')).append('svg').attr('width', width + margin.left + margin.right).attr('height', height + margin.top + margin.bottom).append('g').attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

		data = @get('model')
		_this = this
		data.forEach (d)->
			d.date = d.name
			d.value = +d.age

		x.domain data.map((d) ->
			d.date
		)
		y.domain [
			0
			d3.max(data, (d) ->
				1.3 * d.value
			)
		]
		svg.append('g').attr('class', 'x axis').attr('transform', 'translate(0,' + height + ')').call(d3.axisBottom(x)).append('text').attr('y', 30).attr('dy', '.71em').attr('x', 500).attr('dx', '.71em').style('text-anchor', 'end')
		svg.append('g').attr('class', 'y axis').call(d3.axisLeft(y)).append('text').attr('transform', 'rotate(-90)').attr('y', 6).attr('dy', '-3.50em').style('text-anchor', 'end')

		svg.selectAll('bar').data(data).enter().append('rect'
		).style('fill', (d) =>
			@get('color')[0]
		).attr('x', (d) ->
			x d.date
		).attr('width', x.bandwidth()).attr('y', (d) ->
			y d.value
		).attr('height', (d) ->
			height - y(d.value)
		)

`export default barChartComponent`
