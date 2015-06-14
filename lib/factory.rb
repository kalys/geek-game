module GeekGame
  class Factory < GameObject
    define_properties :production_time

    factory_properties production_time: 1.0

    attr_reader :position, :angle, :production_start_time

    def initialize(options)
      self.position = options[:position]
      self.angle = options[:angle]
      self.player = options[:player]
      self.producing = false

      super()
    end

    def produce!
      return if producing?

      self.producing = true
      self.production_start_time = Time.now
    end

    def update(seconds)
      if producing? and production_time_passed?
        create_bot
        self.producing = false
      end
    end

    def orientation
      Vector.polar(1, angle)
    end

    def producing?
      self.producing
    end

    def progress
      (Time.now - production_start_time) / production_time
    end

    def production_time_passed?
      Time.now - production_start_time > production_time
    end

    protected

    def create_bot
      PewPew.new position: position.advance_by(orientation * 25),
        angle: angle - 90.degrees,
        player: player
    end

    attr_writer  :position, :angle, :production_start_time
    attr_accessor :producing
  end
end
