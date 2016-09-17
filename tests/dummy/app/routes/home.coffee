`import Ember from "ember"`

route = Ember.Route.extend({
  model: ->
    [{name: "abc", age: 5}, {name: "pqr", age: 10}, {name: "xyz", age: 15}]

  setupController: (controller, model) ->
    controller.set('model', model)
    controller.set('color', ["red", "green"])
})

`export default route`
