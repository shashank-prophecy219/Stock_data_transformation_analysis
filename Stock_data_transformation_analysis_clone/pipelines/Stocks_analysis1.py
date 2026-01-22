from prophecy_pipeline_sdk.graph import *
from prophecy_pipeline_sdk.properties import *
configuration = {"schema" : {"type" : "record", "fields" : []}}
metainfo = PipelineGraphMetadata(
    label = "Stocks_analysis1",
    version = 1,
    configuration = configuration,
    schedule = None,
    sensor_schedule = None,
)

with PipelineGraph(id = "Stocks_analysis1", metainfo = metainfo) as graph:
    ma_200_results = PipelineProcess(
        name = "ma_200_results",
        metadata = PipelineNodeMetadata(phase = 0),
        properties = GemProperties.VisualizeSpecProperties(),
        ports = Ports(inputs = [Port(name = "in_0")], outputs = [Port(name = "out_0")])
    )
    stocks_analysis1__q1_final_sorted = PipelineProcess(
        name = "Stocks_analysis1__q1_final_sorted",
        metadata = PipelineNodeMetadata(phase = 0),
        properties = GemProperties.ModelTransformSpecProperties(modelName = "Stocks_analysis1__q1_final_sorted"),
        ports = Ports(
          inputs = [Port(name = "in_0"), Port(name = "in_1"), Port(name = "in_2"), Port(name = "in_3"), Port(name = "in_4"),
           Port(name = "in_5"), Port(name = "in_6"), Port(name = "in_7"), Port(name = "in_8"),
           Port(name = "in_9"), Port(name = "in_10"), Port(name = "in_11"), Port(name = "in_12"),
           Port(name = "in_13")],
          outputs = [Port(name = "out_0")],
          is_custom_output_schema = False
        )
    )
    q1_price_change_results = PipelineProcess(
        name = "q1_price_change_results",
        metadata = PipelineNodeMetadata(phase = 0),
        properties = GemProperties.VisualizeSpecProperties(),
        ports = Ports(inputs = [Port(name = "in_0")], outputs = [Port(name = "out_0")])
    )
    stocks_analysis1__q2_final = PipelineProcess(
        name = "Stocks_analysis1__q2_final",
        metadata = PipelineNodeMetadata(phase = 0),
        properties = GemProperties.ModelTransformSpecProperties(modelName = "Stocks_analysis1__q2_final"),
        ports = Ports(
          inputs = [Port(name = "in_0"), Port(name = "in_1"), Port(name = "in_2"), Port(name = "in_3"), Port(name = "in_4"),
           Port(name = "in_5"), Port(name = "in_6"), Port(name = "in_7"), Port(name = "in_8"),
           Port(name = "in_9"), Port(name = "in_10"), Port(name = "in_11"), Port(name = "in_12"),
           Port(name = "in_13")],
          outputs = [Port(name = "out_0")],
          is_custom_output_schema = False
        )
    )
    stocks_analysis1__ma_final = PipelineProcess(
        name = "Stocks_analysis1__ma_final",
        metadata = PipelineNodeMetadata(phase = 0),
        properties = GemProperties.ModelTransformSpecProperties(modelName = "Stocks_analysis1__ma_final"),
        ports = Ports(
          inputs = [Port(name = "in_0"), Port(name = "in_1"), Port(name = "in_2"), Port(name = "in_3"), Port(name = "in_4"),
           Port(name = "in_5"), Port(name = "in_6"), Port(name = "in_7"), Port(name = "in_8"),
           Port(name = "in_9"), Port(name = "in_10"), Port(name = "in_11"), Port(name = "in_12"),
           Port(name = "in_13")],
          outputs = [Port(name = "out_0")],
          is_custom_output_schema = False
        )
    )
    q3_monthly_avg_results = PipelineProcess(
        name = "q3_monthly_avg_results",
        metadata = PipelineNodeMetadata(phase = 0),
        properties = GemProperties.VisualizeSpecProperties(),
        ports = Ports(inputs = [Port(name = "in_0")], outputs = [Port(name = "out_0")])
    )
    stocks_analysis1__q3_final = PipelineProcess(
        name = "Stocks_analysis1__q3_final",
        metadata = PipelineNodeMetadata(phase = 0),
        properties = GemProperties.ModelTransformSpecProperties(modelName = "Stocks_analysis1__q3_final"),
        ports = Ports(
          inputs = [Port(name = "in_0"), Port(name = "in_1"), Port(name = "in_2"), Port(name = "in_3"), Port(name = "in_4"),
           Port(name = "in_5"), Port(name = "in_6"), Port(name = "in_7"), Port(name = "in_8"),
           Port(name = "in_9"), Port(name = "in_10"), Port(name = "in_11"), Port(name = "in_12"),
           Port(name = "in_13")],
          outputs = [Port(name = "out_0")],
          is_custom_output_schema = False
        )
    )
    q2_best_year_results = PipelineProcess(
        name = "q2_best_year_results",
        metadata = PipelineNodeMetadata(phase = 0),
        properties = GemProperties.VisualizeSpecProperties(),
        ports = Ports(inputs = [Port(name = "in_0")], outputs = [Port(name = "out_0")])
    )
    stocks_analysis1__q2_final >> q2_best_year_results
    stocks_analysis1__q1_final_sorted >> q1_price_change_results
    stocks_analysis1__ma_final >> ma_200_results
    stocks_analysis1__q3_final >> q3_monthly_avg_results
